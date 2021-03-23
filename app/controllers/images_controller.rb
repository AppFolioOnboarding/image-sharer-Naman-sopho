class ImagesController < ActionController::Base
  layout 'application'

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)

    if @image.save
      redirect_to @image
    else
      @error_message = 'Please enter valid URL.'
      render :new
    end
  end

  def show
    @image = Image.find(params[:id])
  end

  def index
    @images = if params[:tag]
                Image.tagged_with(params[:tag])
              else
                Image.order('created_at DESC')
              end
  end

  def destroy
    Image.destroy(params[:id])
    redirect_to images_path
  end

  private

  def image_params
    params.require(:image).permit(:link, :tag_list)
  end
end
