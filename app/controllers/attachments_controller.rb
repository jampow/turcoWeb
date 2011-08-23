class AttachmentsController < ApplicationController

  def index
    @model = params[:model].capitalize.singularize
    @id    = params[:id   ]
    @attachment = Attachment.find(params[:new_id]) if params[:new_id]
  end

  def show
    @attachment = Attachment.find(params[:id])
    send_data @attachment.data, :filename => @attachment.filename, :type => @attachment.content_type
  end

  def create

    table = params[:attachment][:table_rel  ]
    id    = params[:attachment][:external_id]

    if params[:attachment][:uploaded_file].blank?
      flash[:notice] = "Arquivo não encontrtado."
      redirect_to :action => "index", :model => table, :id => id
      return
    end

    @attachment = Attachment.new(params[:attachment])

    if @attachment.save
      flash[:notice] = "Arquivo enviado com sucesso."
      flash[:update_list] = 'true'
      redirect_to :action => "index", :model => table, :id => id, :new_id => @attachment.id
    else
      flash[:error] = "Houve um problema ao enviar o arquivo. Por favor tente novamente."
      render :action => "index", :model => table, :id => id
    end
  end

  # DELETE /attachments/1
  # DELETE /attachments/1.xml
  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy

    respond_to do |format|
      format.html { redirect_to(attachments_url) }
      format.xml  { head :ok }
      format.json { render :json => 'removeParentTR(t);' }
    end
  end

end

