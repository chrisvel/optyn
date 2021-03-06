class Merchants::FileImportsController < Merchants::BaseController

  def index
    @labels = current_shop.labels.import_labels(current_shop)
    @file_imports = current_manager.file_imports.order("created_at DESC")
    @file_import = FileImport.new
  end

  def create

    @file_import = FileImport.new(params[:file_import])
    @file_import.label = params[:label_ids].join(",") rescue ""
    @file_import.manager_id = current_manager.id
    @labels = current_shop.labels
    if @file_import.save
      UserImporter.perform_async(@file_import.id)
      redirect_to merchants_file_imports_path, notice: "Your CSV file has been queued for import. We will send you an email with the statistics once the import is complete."
    else
      render 'index'
    end
  end
end
