class ImagesController < ActionController::Base
  layout 'application'

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(link: params[:image][:link])
    @image.tag_list.add(params[:image][:tag_list].split(',')) unless params[:image][:tag_list].nil?

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
    @images = Image.order('created_at DESC')
  end
end
