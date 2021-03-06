module StripeEventHandlers

  def self.handle_customer_subscription_created(params)
    # binding.pry
    @subscription=Subscription.find_by_stripe_customer_token(params['data']['object']['customer'])
    @subscription.update_attributes(:active => true)
  end

  def self.handle_customer_subscription_updated(params)
    @subscription = Subscription.find_by_stripe_customer_token(params['data']['object']['customer'])
    status = params['data']['object']['status']
    if !@subscription.nil?
      @subscription.update_attributes(:active => ((status == 'active' || status == 'trialing') ? true : false))
    end
    # binding.pry
  end

  def self.handle_customer_subscription_deleted(params)
    @subscription=Subscription.find_by_stripe_customer_token(params['data']['object']['customer'])
    @subscription.update_attributes(:active => false) if @subscription
  end

  def self.handle_plan_deleted(params)
    @plan=Plan.find_by_plan_id(params['data']['object']['id'])
    @plan.destroy if @plan
  end

  def self.handle_plan_created(params)
      @stripe_plan = Stripe::Plan.retrieve(params['data']['object']['id'])
      @plan = Plan.find_by_plan_id(@stripe_plan.id) || Plan.new
      @plan.plan_id = @stripe_plan.id
      @plan.name = @stripe_plan.name
      @plan.interval = @stripe_plan.interval
      @plan.amount = @stripe_plan.amount
      @plan.currency = @stripe_plan.currency
      @plan.save!
  end

  def self.handle_plan_updated(params)
      @stripe_plan = Stripe::Plan.retrieve(params['data']['object']['id'])
      @plan=Plan.find_or_initialize_by_plan_id(params['data']['object']['id']) if @stripe_plan
      @plan.update_attributes(
                              :plan_id => @stripe_plan.id,
                              :name => @stripe_plan.name,
                              :interval => @stripe_plan.interval,
                              :amount => @stripe_plan.amount,
                              :currency => @stripe_plan.currency
                              )
  end

  def self.handle_invoice_created(params)
    # subscription = Subscription.find_by_stripe_customer_token(params['data']['object']['customer'])
    subscription = find_valid_subscription(params)
    # binding.pry
    ##only start creating if subscription is not nil
    if !subscription.nil?
      evaluated_plan = Plan.which(subscription.shop)
      subscription.update_plan(evaluated_plan) if evaluated_plan != subscription.plan
      create_invoice(subscription,params)
    end
  end

  def self.handle_invoice_payment_succeeded(params)
    subscription = find_valid_subscription(params)
    # binding.pry
    amount = params['data']['object']['total']
    conn_count = subscription.shop.active_connection_count rescue nil
    #Send Payment notification mail only when plan is not starter and amount is not 0.
    if not (subscription.plan == Plan.starter and amount == 0)
      #Send Payment successful mail when plan is upgraded, and send Amount credited mail when plan is downgraded.
      if not amount < 0
        PaymentNotificationSender.perform_async( "MerchantMailer", "invoice_payment_succeeded", {shop_id: subscription.shop.id, connection_count: conn_count, amount: amount})

      else
        PaymentNotificationSender.perform_async("MerchantMailer", "invoice_amount_credited", {shop_id: subscription.shop.id, connection_count: conn_count, amount: amount})

      end
    end
    # binding.pry
    update_invoice(subscription,params)
  end

  def self.handle_invoice_payment_failed(params)
    # subscription = Subscription.find_by_stripe_customer_token(params['data']['object']['customer'])
    subscription = find_valid_subscription(params)
    # binding.pry
    subscription.update_attribute(:active, false)
    amount = params['data']['object']['total']
    conn_count = subscription.shop.active_connection_count
    PaymentNotificationSender.perform_async('MerchantMailer', 'invoice_payment_failure', {shop_id: subscription.shop.id, amount: amount, connection_count: conn_count})
    update_invoice(subscription,params)
  end

  def self.handle_invoice_updated(params)
    if params['data']['object']['closed']==true
      # subscription = Subscription.find_by_stripe_customer_token(params['data']['object']['customer'])
      subscription = find_valid_subscription(params)
      update_invoice(subscription,params)
    end
  end

  def self.handle_coupon_created(params)
    stripe_coupon = params['data']['object']
    coupon = Coupon.from_attrs(stripe_coupon)
    coupon.save!
  end

  def self.handle_coupon_deleted(params)
    stripe_coupon = params['data']['object']
    coupon = Coupon.from_attrs(stripe_coupon)
    unless coupon.new_record?
      coupon.deleted = true
      coupon.save
    end
  end

  def self.handle_customer_created(params)
    # binding.pry
    discount_map =params['data']['object']['discount'] rescue nil
    stripe_customer_token =  params['data']['object']['id'] rescue nil
    plan_id = Plan.starter.id #everybody starts with 
    manager_email = params["event"]["data"]["object"]["email"]
    shop_id = Manager.where(:email=>manager_email).first.shop.id rescue -1
    if discount_map.present?
      manage_coupon(discount_map['coupon']['id'], params, params['data']['object']['id'])
    end
    subscription_count = Subscription.where(:stripe_customer_token=>stripe_customer_token).count
    if subscription_count == 0
      @subscription = Subscription.create(
                      :stripe_customer_token=>stripe_customer_token,
                      :shop_id=>shop_id,
                      :plan_id=>plan_id,
                      :email=> manager_email
                      )
    end
  end

  def self.handle_customer_updated(params)
    discount_map = params['data']['object']["discount"]
    if discount_map.present?
      manage_coupon(discount_map['coupon']['id'], params['data']['object']['id'])
    end
  end

  def self.handle_customer_discount_created(params)
    # binding.pry
    manage_coupon(params['data']['object']['coupon']['id'], params['data']['object']['customer'])
  end

  def self.handle_customer_discount_updated(params)
    # binding.pry
    manage_coupon(params['data']['object']['coupon']['id'], params['data']['object']['customer'])
  end

  def self.handle_customer_discount_deleted(params) 
    coupon, shop = fetch_coupon_and_shop(params['data']['object']['coupon']['id'], params['data']['object']['customer'])
    shop.coupon_id = nil
    shop.save(validate: false)
  end

  def self.handle_charge_succeeded(params)
    # binding.pry
    begin 
      fee_description = params[:data][:object][:fee_details].first.description
    rescue
      fee_description = nil
    end
    # binding.pry
    stripe_plan_token = params[:data][:object][:plan][:id] rescue nil
    stripe_invoice_token = params[:data][:object][:invoice] rescue nil
    stripe_charge_id = params[:data][:object][:id] rescue nil

    ##if plan.id is nil and invoice token is present
    if stripe_plan_token.nil? and stripe_invoice_token.present?
      begin
        reply = Stripe::Invoice.retrieve(stripe_invoice_token)
      rescue Stripe::InvalidRequestError #handle 404 No such invoice
        stripe_plan_token = nil
        reply = nil
      end
      if !reply.nil?
        stripe_plan_token = reply[:lines][:data].first["plan"].id rescue nil
      end
    end
    Charge.create(
        :stripe_charge_id => stripe_charge_id,
        :created => params[:created],
        :livemode => params[:livemode],
        :fee_amount => params[:data][:object][:fee] ,
        :stripe_invoice_token => stripe_invoice_token ,
        :description => params[:data][:object][:description] ,
        :dispute => params[:data][:object][:dispute]  ,
        :refunded => params[:data][:object][:refunded] ,
        :paid => params[:data][:object][:paid] ,
        :amount => params[:data][:object][:amount]  ,
        :card_last4 => params[:data][:object][:card][:last4] ,
        :amount_refunded => params[:data][:object][:amount_refunded]  ,
        :stripe_customer_token => params[:data][:object][:customer]  ,
        :fee_description => fee_description ,
        :stripe_plan_token => stripe_plan_token
      )

  end

  def self.handle_invoice_item_created(params)
    #as per discussion with gaurva everytime a invoice line item is created
    #we force stripe to make a invoice which absorbs that invpoice line item , making our view consistent

    create_or_update_invoice_item(params)

    stripe_customer_token = params['data']['object']['customer'] rescue nil
    # binding.pry
    ##Try creating a invoice
    Rails.logger.info 'Try Create Invoice@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'
    Rails.logger.info "Customer " + stripe_customer_token
    begin
      invoice = Stripe::Invoice.create(:customer => stripe_customer_token)
    rescue Stripe::InvalidRequestError  => e
      Rails.logger.info '[Error]Tried Creating a Invoice'+'~'*100
      Rails.logger.info e.to_s
      Rails.logger.info "Customer " + stripe_customer_token
      Rails.logger.info params.to_s
      Rails.logger.info '~'*100
    end
    #Try paying the same invoice
    Rails.logger.info 'Try Paying@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'
    Rails.logger.info "Customer " + stripe_customer_token
    begin
      invoice.pay if !invoice.nil?
    rescue Stripe::InvalidRequestError  => e
      Rails.logger.info '[Error]Tried Paying the Invoice'+'~'*100
      Rails.logger.info e.to_s
      Rails.logger.info "Customer " + stripe_customer_token
      Rails.logger.info params.to_s
      Rails.logger.info '~'*100
    end
  end

  def self.handle_invoice_item_updated(params)
    #as per discussion with gaurva everytime a invoice line item is created
    #we force stripe to make a invoice which absorbs that invpoice line item , making our view consistent
    create_or_update_invoice_item(params)
    
    stripe_customer_token = params['data']['object']['customer'] rescue nil
    stripe_invoice_token = params['data']['object']['invoice'] rescue nil
    # binding.pry
    unless stripe_invoice_token.present?
      begin
        Stripe::Invoice.create(:customer => stripe_customer_token)
      rescue Stripe::InvalidRequestError  => e
        Rails.logger.info '[Error]'+'~'*100
        Rails.logger.info e.to_s
        Rails.logger.info "Customer " + stripe_customer_token
        Rails.logger.info params.to_s
        Rails.logger.info '~'*100
      end
    end
  end

  private
  def self.manage_coupon(coupon_stripe_id, customer_stripe_key)
    #insert discount object into a monthly table
    coupon, shop = fetch_coupon_and_shop(coupon_stripe_id, customer_stripe_key)
    shop.coupon_id = coupon.id
    shop.save(validate: false)
  end

  def self.fetch_coupon_and_shop(coupon_stripe_id, customer_stripe_key)
    coupon = (Coupon.find_by_stripe_id(coupon_stripe_id) rescue nil)
    subscription = Subscription.find_by_stripe_customer_token(customer_stripe_key)
    shop = subscription.shop
    [coupon, shop]
  end

  def self.create_invoice(subscription,params)
    invoice_count = Invoice.where(:stripe_invoice_id=>params['data']['object']['id']).count
    # binding.pry
    ##dont create invoice if its already created
    if invoice_count > 0
      Rails.logger.info '[Error]'+'~'*100
      Rails.logger.info 'Invoice already exists'
      Rails.logger.info params.to_s
      Rails.logger.info '~'*100
      return Invoice.where(:stripe_invoice_id=>params['data']['object']['id'])
    end
    stripe_plan_token = params['data']['object']['lines']['data'].first['plan']['id']  rescue nil
    stripe_coupon_token = params[:data][:object][:discount][:coupon][:id] rescue nil
    stripe_coupon_percent_off = params[:data][:object][:discount][:coupon][:percent_off] rescue nil
    stripe_coupon_amount_off = params[:data][:object][:discount][:coupon][:amount_off] rescue nil
    subtotal = params[:data][:object][:subtotal] rescue nil
    total = params[:data][:object][:total]  rescue nil
    description = params['data']['object']['lines']['data'].first['description'] rescue nil

    Invoice.create(
      :subscription_id => subscription.id,
      :stripe_customer_token => params['data']['object']['customer'],
      :stripe_invoice_id => params['data']['object']['id'],
      :paid_status => params['data']['object']['paid'],
      :amount => params['data']['object']['total'] ,
      :stripe_coupon_token => stripe_coupon_token,
      :stripe_coupon_percent_off => stripe_coupon_percent_off,
      :stripe_coupon_amount_off => stripe_coupon_amount_off,
      :subtotal => subtotal,
      :total => total,
      :stripe_plan_token => stripe_plan_token,
      :description => description
    )
  end

  def self.update_invoice(subscription,params)
    stripe_plan_token = params['data']['object']['lines']['data'].first['plan']['id']  rescue nil
    stripe_coupon_token = params[:data][:object][:discount][:coupon][:id] rescue nil
    stripe_coupon_percent_off = params[:data][:object][:discount][:coupon][:percent_off] rescue nil
    stripe_coupon_amount_off = params[:data][:object][:discount][:coupon][:amount_off] rescue nil
    subtotal = params[:data][:object][:subtotal] rescue nil
    total = params[:data][:object][:total]  rescue nil
    amount = params['data']['object']['total']  rescue nil
    paid_status = params['data']['object']['paid'] rescue nil
    description = params['data']['object']['lines']['data'].first['description'] rescue nil

    invoice = Invoice.where(:stripe_invoice_id=>params['data']['object']['id']).first
    begin
      invoice.update_attributes(
        :paid_status => paid_status,
        :amount => amount,
        :stripe_coupon_token => stripe_coupon_token,
        :stripe_coupon_percent_off => stripe_coupon_percent_off,
        :stripe_coupon_amount_off => stripe_coupon_amount_off,
        :subtotal => subtotal,
        :total => total,
        :stripe_plan_token => stripe_plan_token,
        :description => description
      )
    rescue
      Rails.logger.info '[Error]Issue updating the invoice '+'~'*100
    end
  end

  def self.find_valid_subscription(params)
    begin
      subscription = Subscription.where("stripe_customer_token = \'#{params['data']['object']['customer']}\' and shop_id != -1").first
    rescue
      subscription = nil
    end
    return subscription
  end

  def self.create_or_update_invoice_item(params)
    invoice_item = InvoiceItem.where(:stripe_invoice_item_token=>params['data']['object']['id']).first
    
    if invoice_item.nil? #create invoice item if not present
      stripe_invoice_item_token = params['data']['object']['id'] rescue nil
      invoice_item = InvoiceItem.create(
                      :stripe_invoice_item_token => stripe_invoice_item_token)
    end
    amount = params['data']['object']['amount'] rescue nil
    livemode = params['data']['object']['livemode'] rescue nil
    proration = params['data']['object']['proration'] rescue nil
    description = params['data']['object']['description'] rescue nil
    stripe_customer_token = params['data']['object']['customer'] rescue nil
    stripe_invoice_token = params['data']['object']['invoice'] rescue nil

    invoice_item.update_attributes(
                                  :amount => amount , 
                                  :livemode => livemode ,
                                  :proration => proration ,
                                  :description => description , 
                                  :stripe_customer_token => stripe_customer_token ,
                                  :stripe_invoice_token=>stripe_invoice_token
                                  )
  end

end