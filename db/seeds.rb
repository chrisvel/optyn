# Add the stripe plans
Plan.create(plan_id: 'pro', interval: 'month', name: 'Pro', amount: 10000, currency: 'usd')
Plan.create(plan_id: 'advanced', interval: 'month', name: 'Advanced', amount: 5000, currency: 'usd')
Plan.create(plan_id: 'standard', interval: 'month', name: 'Standard', amount: 2500, currency: 'usd')
Plan.create(plan_id: 'starter', interval: 'month', name: 'Starter', amount: 1000, currency: 'usd')
Plan.create(plan_id: 'lite', interval: 'month', name: 'Lite', amount: 500, currency: 'usd')

#Add the states
State.create(:name => "Alabama", :abbreviation => "AL")
State.create(:name => "Alaska", :abbreviation => "AK")
State.create(:name => "Arizona", :abbreviation => "AZ")
State.create(:name => "Arkansas", :abbreviation => "AR")
State.create(:name => "California", :abbreviation => "CA")
State.create(:name => "Colorado", :abbreviation => "CO")
State.create(:name => "Connecticut", :abbreviation => "CT")
State.create(:name => "Delaware", :abbreviation => "DE")
State.create(:name => "District of Columbia", :abbreviation => "DC")
State.create(:name => "Florida", :abbreviation => "FL")
State.create(:name => "Georgia", :abbreviation => "GA")
State.create(:name => "Hawaii", :abbreviation => "HI")
State.create(:name => "Idaho", :abbreviation => "ID")
State.create(:name => "Illinois", :abbreviation => "IL")
State.create(:name => "Indiana", :abbreviation => "IN")
State.create(:name => "Iowa", :abbreviation => "IA")
State.create(:name => "Kansas", :abbreviation => "KS")
State.create(:name => "Kentucky", :abbreviation => "KY")
State.create(:name => "Louisiana", :abbreviation => "LA")
State.create(:name => "Maine", :abbreviation => "ME")
State.create(:name => "Maryland", :abbreviation => "MD")
State.create(:name => "Massachusetts", :abbreviation => "MA")
State.create(:name => "Michigan", :abbreviation => "MI")
State.create(:name => "Minnesota", :abbreviation => "MN")
State.create(:name => "Mississippi", :abbreviation => "MS")
State.create(:name => "Missouri", :abbreviation => "MO")
State.create(:name => "Montana", :abbreviation => "MT")
State.create(:name => "Nebraska", :abbreviation => "NE")
State.create(:name => "Nevada", :abbreviation => "NV")
State.create(:name => "New Hampshire", :abbreviation => "NH")
State.create(:name => "New Jersey", :abbreviation => "NJ")
State.create(:name => "New Mexico", :abbreviation => "NM")
State.create(:name => "New York", :abbreviation => "NY")
State.create(:name => "North Carolina", :abbreviation => "NC")
State.create(:name => "North Dakota", :abbreviation => "ND")
State.create(:name => "Ohio", :abbreviation => "OH")
State.create(:name => "Oklahoma", :abbreviation => "OK")
State.create(:name => "Oregon", :abbreviation => "OR")
State.create(:name => "Pennsylvania", :abbreviation => "PA")
State.create(:name => "Hode Island", :abbreviation => "RI")
State.create(:name => "South Carolina", :abbreviation => "SC")
State.create(:name => "South Dakota", :abbreviation => "SD")
State.create(:name => "Tennessee", :abbreviation => "TN")
State.create(:name => "Texas", :abbreviation => "TX")
State.create(:name => "Utah", :abbreviation => "UT")
State.create(:name => "Vermont", :abbreviation => "VT")
State.create(:name => "Virginia", :abbreviation => "VA")
State.create(:name => "Washington", :abbreviation => "WA")
State.create(:name => "West Virginia", :abbreviation => "WV")
State.create(:name => "Wisconsin", :abbreviation => "WI")
State.create(:name => "Wyoming", :abbreviation => "WY")

#Add business
Business.create(:name => "Animation")
Business.create(:name => "Apparel & Fashion")
Business.create(:name => "Arts & Crafts")
Business.create(:name => "Books")
Business.create(:name => "Bank & Financial services")
Business.create(:name => "Consumer Electronics")
Business.create(:name => "Cars & Motorcycles")
Business.create(:name => "Education")
Business.create(:name => "Entertainment")
Business.create(:name => "Event Planning/Event Services")
Business.create(:name => "Food & Drink")
Business.create(:name => "Internet/Software")
Business.create(:name => "Hair & Beauty")
Business.create(:name => "Health & Fitness")
Business.create(:name => "Home Decor")
Business.create(:name => "Motion Pictures and Film")
Business.create(:name => "Music")
Business.create(:name => "Nonprofit Organization Management")
Business.create(:name => "Outdoor gear/Sporting Goods")
Business.create(:name => "Photography")
Business.create(:name => "Real Estate")
Business.create(:name => "Social Media")
Business.create(:name => "Technology")
Business.create(:name => "Travel & Tourism")
Business.create(:name => "Transportation")

#Add permissions
Permission.create!(:name => "name")
Permission.create!(:name => "email")

#Add some dummy data in the development mode.
if Rails.env.development?
  user_names = ["Cyclotrimethy Lenetrinitramine",
                "Magnetohy Drodynamically",
                "Trinitrophenyl Methylnitramine",
                "Dicyclopen Tadienyliron",
                "Polytetra Fluoroethylene",
                "Bioelectro Genetically",
                "Phenylethy Lmalonylurea",
                "Interdenomi Nationalism",
                "Desoxyribonuc Leoprotein",
                "Electrocar Diographically",
                "Triacetylo Leandomycin",
                "Antimateria Listically",
                "Electrophy Siologically",
                "Aerobacterio Logically",
                "Antiuti Litarianism",
                "Chorioepithe Liomata",
                "Anatomico Pathological",
                "Magnetother Moelectricity",
                "Poliencephalo Myelitis",
                "Overindiv Idualization",
                "Overintel Lectualization",
                "Deoxyribonu Cleoprotein",
                "Disestablish Mentarianism",
                "Gaurav Gaglani",
                "Jinesh Parekh"]

  user_names.each do |name|
    User.create(:email => "#{name.downcase.gsub(/\s/, "")}@gmail.com", :name => name, :password => "test1234", :password_confirmation => "test1234")
  end

  manager_names = ["Splinterless Loadstar",
                   "Falconine Oversaw",
                   "Sloppier Unproofread",
                   "Snafu Precoiler",
                   "Interabang Pharm",
                   "Unexacerbating Complexly",
                   "Carter Gitana",
                   "Monteux Osmium",
                   "Empiristic  Hypethral",
                   "Imperfectness Dauby",
                   "Fritz Fitzgerald",
                   "Lokayatika Golosh",
                   "Precover weirdo",
                   "Cytoarchitecturally Hulloa",
                   "Condonation Isthmian",
                   "Stralsund Puntillero",
                   "Uncleanness Venturesomely",
                   "Prerejection Galeiform",
                   "Outspin Antiskidding",
                   "Intertropical Joyride",
                   "Ormazd Diabasic",
                   "Seclusiveness Effervescingly",
                   "Juvenile Reuben",
                   "Endothermic Alkahest",
                   "Allopathist Studiable"]


  shop_names = ["Joleen Flick",
                "Mamie Sue",
                "Chantal Vandiver",
                "Herschel Timko",
                "Justine Schooley",
                "Keli Gholston",
                "Leah Boon",
                "Nila Logan",
                "Meryl Spradley",
                "Kiyoko Sandlin",
                "Judith Janowski",
                "Mallory Toto",
                "Melaine Mauzy",
                "Dolores Mitzel",
                "Dionna Vanfleet",
                "Ok Hamaker",
                "Rosendo Delarosa",
                "Lyman Royer",
                "Breanna Vanlandingham",
                "Janessa Weinstein",
                "Dudley Rhem",
                "Paula Fales",
                "Cassie Strite",
                "Ronda Sober",
                "Terence Covarrubias",
                "Joi Helzer",
                "Jettie Reynaga",
                "Lorina Klick",
                "Jacqualine Weckerly",
                "Stephan Colegrove",
                "Samella Miraglia",
                "Augustina Santini",
                "Lena Livesay",
                "Adelina Weidman",
                "Hugh Unknow",
                "Palma Raglin",
                "Jerrold Shane",
                "Sol Martinelli",
                "Alethia Rakow",
                "Hiedi Sun",
                "Alda Hefner",
                "Ebony Settles",
                "Nita Stall",
                "Richie Alba",
                "Vanna Longmore",
                "Neta Kall",
                "Renata Hank",
                "Ciara Font",
                "Daniell Depaolo",
                "Hilde Overstreet"]

  manager_names.each_with_index do |name, index|
    shop = Shop.create!(:name => shop_names[index], :stype => "local")
    manager  = shop.managers.create(:name => name, :email => "#{name.downcase.gsub(/\s/, "")}@idyllic-software.com", :password => "test1234", :password_confirmation => "test1234")
    manager.confirm!
    manager.save!
  end

  questions = ["How old are you?", "Whats your Birthday?", "What starsign does that make it?", "Whats your favourite colour?", "Whats your lucky number?", "Do you have any pets?", "Where are you from?", "How tall are you?", "What shoe size are you?", "How many pairs of shoes do you own?", "If you were prime miniser/ruler of the world what laws would you make?", "If you were a super hero what powers would you have?", "and what would your hero name be?", "and what outfit would you wear?", "What was your last dream about?", "What would you do if you won the lottery?", "Would you like to build/design your own house?", "Which form of public transport do you prefer?", "What talents do you have?", "Can you juggle?", "Can you solve a rubix cube?", "Do you have a cherished childhood teddybear?", "Are you psychic in any way?", "Are you a good dancer?", "Are you a good singer?", "Are you a good cook?", "Are you a good artist?", "Are you a good listener?", "Are you a good public speaker?", "Are you a good babysitter?", "Are you a good mechanic?", "Are you a good diplomat?", "Are you a good employee?", "Are you a good dresser?", "Are you a good swimmer?", "Are you a good skier?", "Are you a good lover?", "Are you a good musician?", "Are you a good comedian?", "Are you a good cleaner?", "Are you a good actor?", "Are you a good writer?", "Have you ever been bungee jumping?", "Have you ever been canoeing/kayaking?", "What types of holidays do you prefer?", "Whats the furthest you've ever been on holiday?", "What was your favourite holiday?", "Where would your dream holiday be?", "Can you tap dance?", "Whats your favourite zoo animal?", "Whats your favourite sport?", "Whats your favourite food?", "Whats your favourite pizza topping?", "Whats your favourite film?", "Whats your favourite song?", "Whats your favourite alcoholic drink?", "Whats your favourite non-alcoholic drink?", "Whats your favourite TV program?", "Whats your favourite boyband?", "Whats your favourite girl group?", "What would be your ideal partner?", "Do you want children?", "Do you want a church wedding?", "Are you religious?", "Do you like reality TV programs?", "Do you like TV talent shows?", "If you were gay who would your life partner be?", "If you could go back in time to change one thing what would it be?", "How many hats do you own?", "Are you any good at pool?", "Whats the highest you've ever jumped into the water from?", "Have you ever been admitted to hospital?", "Have you ever had any brushes with the law?", "Have you ever been on TV?", "Have you ever met any celebrities?", "Have you ever been to Legoland?", "Have you ever done something heroic?", "Have you ever played a practical joke on anyone?", "Have you ever been the recipiant of a practical joke?", "What would be your best achievement to date?", "Do you prefer baths or showers?", "Do you prefer towel drying, blow drying or natural dryin your hair?", "Have you ever built a snowman?", "Have you ever been sledging?", "Have you ever flown a kite?", "What colour socks are you wearing?", "If you could live anywhere, where would that be?", "Have you ever been famous?", "Would you like to be a big celebrity?", "Would you ever go on Big Brother?", "How big is your TV?", "What is your most essential appliance?", "What type of music do you like?", "Have you ever been skinnydipping?", "How many Pillows do you sleep with?", "What position do you often sleep in?", "What do you wear to bed?", "How big is your house?", "Do you prefer sunrises or sunsets?", "What do you typically have for breakfast?", "Do you like scary movies?", "Whats your favourite Milkshake flavour?", "Have you ever been in a newspaper?", "How long can you balance on one foot?", "Have you ever fired a gun?", "Have you ever tried archery?", "Whats your favourite condement?", "Whats your favourite clean word?", "Whats your favourite swear word?", "Whats your least favourite word?", "What was the last film you saw?", "What football team do you support?", "Whats the longest you've gone without sleep?", "Whats the tallest building you've ever been up?", "Do you have any scars?", "Do you like marmite?", "Did you ever win any sportsday events?", "What did you want to be when you grew up?", "If you could change anything about yourself what would it be?", "Whats the longest you've ever grown your hair?", "Are you scared of flying?", "Would you rather trade some intelligence for looks or looks for intelligence?", "Have you ever tie-dyed your own clothes?", "How often do you buy new clothes?", "Are you reliable?", "Are you proud of yourself?", "Have you ever had a secret admirer", "If you could ask your future self one question what would it be?", "Do you hold grudges?", "If you could breed two animals together to defy the laws of nature what new animal would you create?", "Do you decorate the outside of your house for christmas?", "Can you solve sudoko puzzles?", "Have you ever played conkers?", "Whats the most unusual conversation you've ever had?", "Are you much of a gambler?", "Are you much of a daredevil?", "Are you a good liar?", "Are you a good judge of character?", "Are you any good at charades?", "How long could you go without talking?", "What has been your worst haircut/style?", "Can you iceskate?", "Can you summersault?", "Whats your favourite joke?", "Whats been your best present?", "Whats been your worst present?", "Have you ever sleepwalked?", "Can you build a house of cards?", "Whats your favourite TV advert?", "Can you play poker?", "If your parents hated your partner you currently loved would you ditch him or carry on with him despite the protests?", "Have you ever been professionally photographed?", "Have you ever baked your own cake?", "Whats your favourite fruit pastel colour?", "What traditionally adorns the top of your christmas tree?", "What would be your dream sandwich?", "Can you inpersonate anyone famous?", "Can you do any accents other than your own?", "Do you have a strong local accent?", "Whats your favourite accent?", "In O's and X's which do you normally pick?", "Do you prefer blue or black inked pens?", "What was the last thing you recorded off TV?", "What was the last thing you dressed up as for fancy dress?", "Do you prefer green or red grapes?", "What do you like on your toast?", "Do you prefer liquid soap or bars of soap?", "How do you have your eggs?", "Whats your favourite saying?", "Have you ever been in a tug of war?", "and did you win?", "Can you stand on your hands unassisted?", "What do you have on your fridge door?", "Do you love or hate myspace?", "Who was the last person to knock/ring at your door?", "How old were you when you last went trick or treating?", "Have you ever been bobbing for apples?", "Whats your most expensive piece of clothing?", "Whats the last thing you took a picture of?", "Whats the last thing you drew a picture of?", "Have you ever bought anything from ebay?", "Whats your favourite smell/scent?", "Can you blow bubbles with bubblegum?", "What was your favourite birthday?", "Can you curl your tounge?", "Is your bellybutton an innie or outie?", "What would be your dream car?", "Are you left or right handed?", "What was the last book you read?", "What was the last song you danced to?", "Have you ever owned a yo-yo?", "Have you ever been on a pogo stick?", "Have you ever been on a space hopper?", "Who was the last person to send you a text message?", "Have you ever accidentally injured anyone?", "Are you scared of spiders?", "Can you down a pint (of anythingin one?", "Have you ever been banned from a public place?", "How much spam email do you tend to get a week?", "If you could learn any language fluently what would it be?", "What historical Figure would you love to see in 21st centuary life?", "As a kid were you ever frighted of a monster under the bed or in the cupboard?", "Do you like clowns?", "Do you prefer BBC or ITV?", "Have you ever been surfing?", "Have you ever been snowboarding?", "Who was better, the Beatles or Elvis Presley?", "Whats your favourite type of foreign food?", "Which Foreign country do you dislike the most?", "Do you like your music loud or easy listening?", "Whats your favourite animated or cartoon program?", "Do you sing in the shower?", "Are you a clean or messy person?", "Whats your prefered playing piece in monopoly?", "Can or Do you still play twister?", "Can you play chess?", "Do you know the dance steps to an annoying cheesey pop song?", "Do you prefer straight or bendy straws?", "Have you ever entered a talent contest?", "and did you win?", "Do you like poetry?", "Are you a bad loser?", "Which would you choose? Jelly or Ice Cream?", "Whats your favourite type of Pie?", "Whats your most used phrase?", "Whats your most used word?", "Who would you want to play you in a movie of your life?", "What would your dream job be?", "Which song do you hate the most?", "How long does it take you to get ready?", "What do you think the greatest invention has been?", "Whats your favourite feature on the opposite sex?", "Whats your least favourite feature on the opposite sex?", "Who's your favourite Comedian?", "What's your favourite board game?", "Do you have any lucky items, objects or traditions?", "Do you have any superstitions?", "Whats your favourite Movie quote?", "Who would win in a fight? Chuck Norris or Jack Bauer?", "Do you have much of an ego?", "Do you wear sunglasses indoors to look cool or stylish?", "Are you a hat person?", "Whats your favourite supermarket chain?", "Whats your favourite fastfood chain?", "Whats your first thought upon waking up?", "What animal would you most like to have as a pet?", "Whats your favourite type of tree?", "If you could bankrupt one person or company who would it be?", "If you could steal one thing without consequence what would it be?", "Who's your favourite celeb with the same first name or surname as you?", "If evil-doers invaded your country would you rush to the battlelines to defend the motherland or hide in a box?", "Whats your favourite flower?", "Do you believe in ghosts?", "Do you believe in the loch ness monster?", "Do you believe in Aliens?", "Do you believe the Governments hide technology and information from the public?", "Which is your favourite pokemon?", "What horror fiction character scares you the most?", "Can you do 10 revolutions of a hula hoop?", "Do you think Great Britain should have a National Day?", "Do you think Great Britain should be part of a United Europe?", "Would you want the Euro or keep the British Pound?", "Were you part of the Brownies/Cubs/Scouts/Guides etc", "Have you ever invented a fairly unique meal or drink?", "Do you have any secret family recipes?", "Do you have any family secrets? :o", "Are you good at keeping secrets?", "Have you ever been up in a hot air balloon?", "Whats your favourite Sci-fi film/program etc?", "When playing checkers or chess do you prefer to be black or white?", "Which is better, a Pastie or Sausage Roll?", "Do you prefer shopping on the high street or online?", "Would you ever want to learn to fly?", "Do you often read your horoscope?", "Have you ever had a proper Tarot reading?", "Whats your favourite brand of newspaper?", "Have you ever milked a cow?", "Have you ever used the phrase \"back in my time\" to someone younger than you?", "Do you love or hate rollercoasters?", "Which was the greatest Empire?", "Whats the cleverest word you know?", "Whats your favourite sportsware brand?", "Do you buy any weekly/monthly magazines?", "Who's your favourite Superhero?", "Who's your favourite Villain/Baddie?", "What was the last Album you purchased?", "What was the last DVD you purchased?", "What was the last piece of clothing you purchased?", "When pulling crackers does everyone get one each regardless or whoever gets the big ends keeps all the prizes", "Do you ever make your own greetings cards", "Do you have a swiss army knife?", "At what age did you twig onto the fact Santa wasnt real?", "Whats your favourite fruit?", "Have you ever done something really unbelivable, only to have no one around to see it?", "Do you buy from charity shops?", "Have you ever sold your services?", "Have you ever raised money for charity?", "Have you ever won a giant sized cuddly toy from a fair?", "Is the glass half full or half empty?", "Is the grass greener on the other side?", "If a tree falls in the forest and there's no one around to hear it does it make a noise?", "Why does it always rain on me?", "Have you ever sailed a boat?", "Do you love or loathe Harry Potter?", "Do you do your utmost for the environment?", "Do you love or loather Eurovison?", "Have you ever weilded a sword?", "If you were famous would you want a statue or a building names after you?", "Whats your favourite type of fish?", "Which do you prefer pony tails or pig tails?", "Whats the ultimate cake topping?", "Do you like marzipan?", "Whats better? Center Parks or Butlins?", "If you were in a band, what instrument/role would you play?", "Can you erect a tent?", "Do you suck or bite lollipops?", "Have you ever used the yellow pages?", "If you have an mp3 player what size is it?", "Do you still have any music on vinyl or casettes?", "Do you still have a camera that uses conventional film?", "Approximately how many DVD's do you have?", "Approximately how many Albums do you have?", "Do you talk to yourself?", "Do you sing to yourself?", "Do you know any identical twins?", "Have you ever given blood?", "Could you ever be a medical guineapig?", "Whats your favourite radio station?", "Whats your favourite letter of the Alphabet?", "Which is better? rollerblade or rollerskates?", "Have you ever written a love letter?", "How many valentines cards did you recieve this/last year?", "What are cooler? Dinosaurs or Dragons?", "Have you ever made your own ice lollies?", "Have you ever made your own Ice cream?", "Which forgeign language did you have to learn at school?", "and do you still remember enough to hold a conversation in that language?", "Do you know CPR?", "Do you have any swimming badges?", "Do you prefer digital or rotary/analogue clocks?", "How tall is the tallest person you know?", "Have you ever got lost in a maze?", "Have you ever been attacked by a wild animal?", "Have you ever ridden a camel?", "Whats your opinion on rats?", "Have you ever been to a gym?", "Have you ever been in a helicopter?", "Have you ever cheated at a test?", "Have you ever ridden a tractor?", "Are you a gossip?", "Have you ever cried at a film?", "When you're ill do you struggle on regardless or just curl up in bed as much as possible?", "Do you need to write down things to remember them?", "Do you keep a diary/journal?", "Are you scared of thunderstorms?", "Do you have any unusual fears or phobias?", "Whats your favourite disney movie?", "Have you ever slept in a caravan?", "Have you ever painted a house?", "Have you got green fingers?", "Whats the tallest tree you've ever climbed?", "Have you ever dialed the talking clock?", "Do you always wear identical socks?", "Do you live by any motto or philosophy?", "Do you lick the yoghurt or desert lid?", "Do you lick the spoon clean after making something sweet?", "Do you like the sound of music? (the musical/film)", "Have you ever made your own orangejuice?", "Have you ever sucked on a lemon?", "Have you ever licked a battery?", "Are you a good aim with a rubber band?", "Have you ever played golf?", "Whats the most unusual name you've ever come across?", "Do you prefer to wash in the mornings or evenings?", "Have you ever danced in the rain?", "Do you like long or short hair?", "Have you ever sworn at an authority figure?", "Have you ever walked into a wall?", "Whats your favourite precious metal?", "Whats your favourite precious stone?", "Could you ever hunt your own meal?", "Have you ever read any comics?", "Where do you like to go to on a first date?", "Do you prefer vertical or horizontal stripes?", "Have you ever baked your own bread?", "Can you believe I can't believe its not butter is in fact not actually butter?", "Can you name all 50 American states?", "Have you ever owned a goldfish?", "What was your favourite school subject?", "What was your least favourite school subject?", "Have you ever passed wind in an embarassing situation?", "Have you ever played the bongos?", "Have you ever handled a snake?", "Have you ever assembled furniture by yourself?", "When did you last go to the beach?", "When if ever did you last go to london?", "What do you do to cool down when its hot?", "Whats the most unusual thing you've ever eaten?", "Do you have a favourite mug?", "Do you know any self defence or martial arts?", "Who's your favourite movie action hero?", "Have you ever ridden a motorcycle?", "Do you collect anything?", "Is there anything you wished would come back into fashion?", "Do you stick to conventional fashions or like to try and be original?", "Have you ever given someone a handmade present?", "Are you introvert or extrovert?", "If you could have any feature from an animal what would you want?", "Whats your prefered swimming stroke?", "Have you ever been scuba diving?", "Have you ever had a disasterous interview?", "What makes you nervous?", "Which of the 5 senses would you say is your strongest?", "What colour are your eyes?", "Have you ever been to an Art gallery?", "Do you shout out the answers at the TV whilst watching quiz shows?", "Are you a valuable asset on a Pub Quiz team?", "Have you ever won any kind of quiz yourself?", "Do you get over-involved with TV or movie plots at times?", "Do you own any inflatable furniture?", "Whats the highest hill or mountain you've ever climbed?", "Do you have a piggy bank?", "Whats the fastest you've ever travelled in a car?", "Could you ever hand milk a cow?", "Do you have popcorn with a movie?", "Whats the futhest you've ever got a paper airplane to fly?", "Have you ever built an igloo?", "Can you play the harmonica?", "Have you ever made a ball of twine or rubberbands?", "If given the option of having a flake in your ice cream do you always take it?", "Could you ever be a living organ donor?", "Which was your favourite science? Biology, Physics or Chemistry?", "Could you ever go out with someone just cause they're rich?", "Have you ever contemplated sueing someone?", "Are you pretty devious?", "Have you ever had a surprise party? (that was an actual surprise)", "Are you any good at giving massages?", "Whats been your worst date ever?", "Have you ever slapped somoene in public?", "Have you ever drawn on a sleeping or inebriated person?", "Have you ever warn clothing with the labels/tags still attached?", "Have you ever slipped on a banana skin?", "Are you scared of the dark?", "Do you have a lawyer?", "Have you ever been wolf whistled in public?", "Whats the worst chatup line you've heard?", "Have you ever been water skiing?", "Have you ever hopelessly failed a test?", "If you had a year off, what would you want to do?", "How many sms/txt messages do you recieve on average a day?", "How long did you last phone call last?", "Do you go to car boot sales?", "If you saw someone drop a 10 note, would you claim it for your own or try to return it to them?", "Have you ever helped someone across the road?", "Have you ever been horseriding?", "Have you ever walked a tightrope?", "Have you ever demolished a wall or building?", "If you and a friend both wanted the same thing would you let the friend get it first?", "Have you ever argued over who should pay for something?", "Do you have any family heirlooms?", "Are you related or distantly related to anyone famous?", "Whats your favourite ocean?", "Do you correct peoples mistakes?", "Have you ever helped out an injured animal?", "Do you throw bread for the ducks?", "Do you think babies are little bundles of joy or smelly noisey things?", "Do you give money to buskers?", "Have you ever tossed your own pancake?", "Are you any good at egg and spoon races?", "Are you allergic to anything?", "Are you ticklish?", "Do you prefer tea,coffee or cocoa?", "Do you like Turkish Delight?", "Do you buy people presents to bring back when you go on holiday?", "Are you tired of answering questions yet?", "Have you ever been wheelbarrow racing?", "Do you ever forward or reply to chain mails?", "Do you often have a tune in your head you can't name?", "Has anyone ever approached you thinking you were someone else?", "Have you ever been approached by someone who knew you but you couldn't remember them for the life of you?", "What do you do to keep fit?", "Are you the sort to step in and try to break up a fight?", "Have you ever been in a fight?", "Have you ever started a rumour?", "Have you ever heard any outstanding rumours about yourself?", "Have you ever been in or had a food fight?", "When its your birthday do you always wear an age badge?", "Have you ever starred in an amateur or professional video?", "If you were comfortbly rich would you work hard for more or rest on your laurels?", "Have you ever been in a position of authority?", "Have you ever been caught in a comprimising position? even despite a valid explanation?", "Have you ever tried to make your own alcohol?", "If you were ruler of your own country what would you call it?", "And what title would you give yourself?", "If you invented a monster what would you call it?", "And what features would it have?", "Have you ever had a dream you chased only to be let down when you achived it?", "Is there anything about the opposite sex you just don't understand or comprehend?", "Who was your favourite teacher at school and why?", "Whats your favourite party game?", "Is it acceptable or unacceptable to smack a child as form of disapline?", "Can a hetrosexual male ever wear pink?", "Is it criminal to wear socks with sandals?", "If you were captain of a ship, what would you call it?", "If you were to join an emergency service which would it be?", "If you were to join one of the armed forced which would it be?", "Whats the worst thing about being your gender?", "Whats the best thing about being your gender?", "If you swapped genders for a day how would you spend it?", "If you were exiled what country would you choose as your new home?", "Have you ever made someone cry?", "Have you ever starred in a school play?", "Were you a member of any celebrity fanclub?", "Have you ever been a member of any other club?", "If you could have a full scholarship to any university what would you choose to study?", "Whats been your greatest ever day?", "What historical period would you like to live in if you could go back in time?", "What would you bring along to an idillic picnic?", "Whats your favourite childrens story?", "What movie ending really frustrated you? And how would you change it?", "What three things do you think of most each day?", "What do you call your evening meal? Dinner Tea or Supper?", "What do you call your after meal sweet? Pudding or Dessert?", "If you had a warning label, what would yours say?", "Have you ever got sweet revenge on anyone?", "Have you ever been to a live concert?", "Have you ever been to see stand up comedy?", "Have you ever needed stitches?", "If you could invent brand new baby names what would they be?", "Do your dreams ever tell you to do anything?", "Who's your favourite radio 1 DJ?", "Whats the best way to your heart?", "Do you know your own mobile phone number off by heart?", "If you were a fashion designer, what style of clothing or accessories would you design?", "Do you ever laugh at things you shouldn't?", "Have you ever been in a submarine?", "Have you ever walked out of a cinema before the film was done?", "What song would you say best sums you up?", "Do you have any old friends wou wish you could meet up with again?", "Whats your favourite Nursury Rhyme?", "Do you prefer metric or imperial measurements?", "Who's your favourite monarch of all time?", "What was the last thing you ate?", "Whats your favourite farmyard animal?", "If you could choose one celebrity to be the father/mother of your child who would it be?", "What would you do if someone proposed to you tomorrow?", "What are your 3 favourite internet sites?", "How high can you jump?", "Which fictional character do you wish was real?", "Who was your first crush?", "Whats the greatest thing about being your nationality?", "Whats the least greatest thing about being your nationality?", "Do you believe in destiny, fate or free will?", "If you could talk to one species of animal which would it be?", "If you had friends round what DVD's would you have to watch?", "Do you like vanilla or chocolate?", "Are you a giver or a receiver?", "Do you have any enemies?", "Are you scared of needles?", "How many piercings do you have? if any", "Have you ever got majorly lost trying to get somewhere?", "How fast can you say the alphabet?", "Do you say \"Zee\" or \"Zed\" to describe the letter Z?", "What was the last thing to make you feel happy?", "What was the last thing to make you feel angry?", "You are walking to work. There is a dog drowning in the canal on the side of the street. Your boss told you if you are late one more time you're fired. Do you save the dog?", "Are you the kind of friend you'd want to have as a friend yourself?", "Do you have any questions or queries about things you're just to scared or embarassed to ask anyone about?", "If you were a wrestler what would your stage name be?", "and what would your special move be called?", "Whats the most interesting thing you can see out of your nearest window?", "Do you think Barbie is a negative role model for young girls?", "Have you ever needed an eye test?", "Do you find yourself attractive?", "Can you roll your R's?", "What social class do you consider yourself or your family background to be in?", "Do you know any magic tricks?", "Whats the largest amount of money you've ever won?", "Whats the largest amount of money you've spent in one spree?", "Whats the largest amount of money you've had to borrow off of a friend or family member", "Have you ever been on a cable car?", "Do you prefer Honey or Jam?", "Do you prefer the French or Germans?", "How fast can you get changed?", "How fast do you type?", "How fast can you run?", "Which is better, Mario or Sonic?", "Whats your favourite biscuit to dunk?", "Which would you rather have if you had to, a broken leg or a broken arm?", "Do you read a daily newspaper?", "Do you watch the news on TV?", "Have you ever had anything published?", "Do you believe in love at first sight?", "How many remote controls do you have in your house?", "Have you ever been in a hot tub or sauna?", "Have you ever had chicken pox?", "Do you own a lava lamp?", "Are you glad these are almost over?", "On a scale of 1-10 how random would you say these are?", "What is your one major weekness?", "Whats been the best descision you've made in your life so far?", "Whats been the worst descision you've made in your life so far?", "What words do you always struggle to spell correctly?", "On a scale of 1-10 how happy would you say you are?", "On a scale of 1-10 how smart would you say you are?", "On a scale of 1-10 how funny would you say you are?", "On a scale of 1-10 how devious would you say you are?", "On a scale of 1-10 how awesome would you say you are?", "On a scale of 1-10 how devilsh would you say you are?", "On a scale of 1-10 how nice/caring would you say you are?", "On a scale of 1-10 how bitchy would you say you are?", "On a scale of 1-10 how polite would you say you are?", "On a scale of 1-10 how attractive would you say you are?", "If you could be any famous person who would you be and why?", "Whats your favourite animal beginning with the letter A?", "Whats your favourite item of clothing beginning with the letter B?", "Whats your favourite expleitive beginning with the letter C?", "Whats your favourite boys name beginning with the letter D?", "Whats your favourite girls name beginning with the letter E?", "Whats your favourite book beginning with the letter F?", "Whats your favourite bodypart beginning with the letter G?", "Whats your favourite musical instrument beginning with the letter H?", "Whats your favourite song beginning with the letter I?", "Whats your favourite actress beginning with the letter J?", "Whats your favourite actor beginning with the letter K?", "Whats your favourite film beginning with the letter L?", "Whats your favourite tv show beginning with the letter M?", "Whats your favourite game beginning with the letter N?", "Whats your favourite non alcoholic drink beginning with the letter O?", "Whats your favourite food beginning with the letter P?", "Whats your favourite band beginning with the letter Q?", "Whats your favourite author beginning with the letter R?", "Whats your favourite sport beginning with the letter S?", "Whats your favourite job beginning with the letter T?", "Whats your favourite mythical creature beginning with the letter U?", "Whats your favourite alcoholic drink beginning with the letter V?", "Whats your favourite cartoon character beginning with the letter W?", "Whats your favourite word beginning with the letter X?", "Whats your favourite city beginning with the letter Y?", "Whats your favourite country beginning with the letter Z?", "Do you get seasick?", "If you discovered a new species of dinosaur what would you call it?", "Do you own a paddling pool?", "What do you consider is the most important piece of furniture in a house?", "What do you consider is the most important appliance in a house?", "If you could have any celebritys hair whos would it be?", "Which Celebrity do you find the most annoying?", "What potential talents do you think you might have if you worked at them?", "Who was better, Flipper, Lassie or Skippy?", "If you could be trained up in any profession of your choice by top professionals what profession would you choose?", "If someone elses child was being an annoying little runt would you go tell them off or do something about it?", "Do you believe in kharma?", "Do you believe in revenge?", "Do you believe in fairies?", "Do you believe in a god?", "Do you believe there used to be dragons?", "Who would you want to be with on a desert island?", "What's the worst show on television?", "Who's your favourite god from ancient history?", "What one device would you want to see added to a mobile phone?", "Where do you see yourself in 1 months time?", "Where do you see yourself in 1 years time?", "Where do you see yourself in 10 years time?", "What was the best thing about your old school?", "What was the worst thing about your old school?", "If you could change your name to anything what would your new name be?", "Do you watch too much tv?", "Have you ever planted a tree?", "Whats the heaviest thing you can lift?", "What was the last present you recieved?", "Are your ears lobed or attached?", "How often do you wash your ears?", "Could you go out with someone who had a child from a previous relationship?", "What was your first alcoholic drink?", "What was your first job?", "What was your first car? (or what would you like it to be?)", "What was your first mobile phone?", "What is your first proper memory?", "Who was your first teacher?", "Where did you go on your first ride on an airplane?", "Who was your first best friend?", "What was your first detention for?", "Whats your strongest voluntary muscle?", "Who was your first kiss?", "What was the first film you remember seeing at the cinema?", "What thing that you've made are you most proud of?", "Could you ever be someones bodygaurd?", "Michelangelo's David... Masterpiece or filth?", "Do you like other people buying you clothes?", "Have you ever brought a present for someone that they hated/disliked?", "What nicknames do you have/have had?", "Did you have any pretend or imaginary friends?", "Have you ever seen a therapist/shrink?", "Have you ever carved a pumpkin?", "Would you say you are a good or bad influence to others?", "Do you prefer giving or recieving gifts/help etc", "If you were a member of the spice girls, what would your spice handle be?", "If you were to become a famous singer, what would your debut album be called?", "If you could join any music group which would you want to join?", "What do your parents do?", "If you were a giant mega monster what city would you rampage?", "Did you ever have a treehouse as a kid?", "Is your dad an embarassing dancer?", "Do you plan to vote in the next election?", "If you could replace one bodypart with a super bionic replacement what bodypart and what features would the new bionic replacement have?", "What if any unusual objects have you swallowed?", "When you buy something new do you get a desire to use/play with it even when they dont have any physical application yet?", "Did you understand the Matrix Trilogy?", "Would you rather be the fella in a movie who gets the girl or the baddie with all the good lines?", "If you were stinking rich, would you only go to places other rich people went?", "Would you rather have a mans top half and a womens bottom half or visa versa?", "Rebound relationships, good or bad?", "Have you ever owned a slinky?", "Teenage parents, good bad or indifferent?", "Whats the most expensive thing you've ever broken?", "Pirate downloads, good or bad?", "Democracy, good or bad?", "Communism, good or bad?", "Have you ever been electrocuted?", "Have you ever been attacked with a creamy bakery product?", "Have you ever shawn a sheep?", "Have you ever accidentally set fire to yourself?", "Have you ever eaten a whole tube of pringles by yourself?", "Have you ever been hit on by someone of the same gender?", "The war in Iraq, good or bad?", "The war in Afganistan, good or bad?", "Have you ever appeared on youtube?", "Have you ever performed in front of a large audience?", "Have you ever eaten anything prepared by a celebrity chef?", "Have you ever been on radio?", "Did your school make a teatowel that everyone submitted to?", "What colour/style was your school tie?", "Do you have to wear glasses?", "Do you bite your nails?", "Do you prefer male or female singers voices?", "Would you rather be the worlds greatest football player or lover?", "Do you get hayfever?", "Do you have a list of things to do before your 'x' years old?", "Do you like your age?", "Whats your favourite physical thing you like about yourself?", "Whats your least favourite physical thing you like about yourself?", "Are you proud, comfortable or ashamed of your body?", "Whats your favourite personality trait you like about yourself?", "Whats your least favourite personality trait you like about yourself?", "Do you know html?", "Have you ever flown first class?", "How many languages do you speak?", "What are better, violins or pianos?", "Whats the fastest you've ever driven? (as driver or passenger)", "What compulsions do you have?", "What makes you angry?", "If you could see any band, which would you like to see?", "Who would you say are more attractive, English or Europeans?", "What would you say is your favourite album of all time?", "Do you dislike hairy people?", "Are you much of an adventurer?", "Do you like your own name?", "Would you ever sign a Prenuptial agreement?", "How long has your longest ever phone call been?", "Have you ever stolen anything?", "Could you ever have an affair with a married person?", "Could you ever split up a couple for one reason or another?", "What is your family christmases like?", "Do you prefer sporty or academic members of the opposite sex?", "How much would it cost to buy your love?", "Who was your least favourite teacher at school and why?", "If you met a Genie who offered you three wishes, what would you wish for? (more wishes does not count)", "Whats your current Mobile phone model and do you like it?", "Have you already thought about your babies names?", "Have you ever been fishing?", "Have you ever had your national flag painted on your face?", "Do you have any strange body things?", "What was the last social faux pas you made?", "What makes you nostalgic?", "Whats the scariest thing you've ever done?", "What fairy tale character would you most associate with?", "How much do you tend to swear in public?", "What are your strengths?", "What are your weaknesses?", "What brand are your trainers?", "If you ruled your own country, who would you get to writer your national anthem?", "Who is the most intelligent person you know?", "Whats the craziest thing you've ever done for someone?", "How did you get your name?", "Whats the best piece of advice anyone has ever given you?", "If you had to describe yourself as a flavour, what would it be?", "If you had to describe yourself as a car, what would it be?", "If you had to describe yourself as an animal, what would it be?", "Do you think laughing at someone elses misfortune is wrong?", "If a loved one was to serenade you, what song would you most like them to sing?", "Would you ever let your parents pick out a partner for you?", "Have you ever tried spam? (the meat product)"]

  users = User.all
  shops = Shop.all

  shops.each do |shop|
    survey = shop.survey
    survey.title = shop.name + " questionaire"
    survey.save!
    survey.reload
  end

  users.each_with_index do |user, index|
    shop = shops[index]
    survey = shop.survey

    SurveyQuestion::ELEMENT_TYPES.each_with_index do |element_type, index_element_type|
      survey_question = survey.survey_questions.create(:element_type => element_type, :label => questions[rand(questions.length)], :position => (index_element_type + 1))
      unless element_type.include?("text")
        survey_question.values = ["Option 1", "Option 2", "Option 3"]
        survey_question.save
      end

    end

    shops.each do |shop|
      connection = Connection.create(:user_id => user.id, :shop_id => shop.id)
    end
  end

  users = users.slice(0, 19)

  puts "User Size: #{users.size}"

  users.each_with_index do |user, index|
    puts "Answer Questions for User: #{index} - #{user.name}"
    connected_shops = user.shops
    surveys = connected_shops.collect(&:survey)
    surveys.each do |survey|
      survey_questions = survey.survey_questions

      survey_questions.each do |question|
        SurveyAnswer.create(:user_id => user.id, :survey_question_id => question.id, :value => ["This is a test"])
      end
    end
  end
end