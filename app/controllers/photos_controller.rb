class PhotosController < ApplicationController
  before_action :set_photo, only: %i[show edit update destroy]

  # GET /photos/1 or /photos/1.json
  def show; end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit; end

  # POST /photos or /photos.json
  def create
    @photo = Photo.new(photo_params)

    respond_to do |format|
      if @photo.save
        format.html do
          redirect_to gallery_url(params[:gallery_id]), notice: 'Photo was successfully created.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1 or /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html do
          redirect_to gallery_photo_url(gallery_id: params[:gallery_id], id: @photo.id),
                      notice: 'Photo was successfully updated.'
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1 or /photos/1.json
  def destroy
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to gallery_url(params[:gallery_id]), notice: 'Photo was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_photo
    @photo = Photo.find_by(id: params[:id], gallery_id: params[:gallery_id])

    raise ActiveRecord::RecordNotFound if @photo.nil?
  end

  # Only allow a list of trusted parameters through.
  def photo_params
    params.fetch(:photo, {}).permit(:name, :shooting_date, :short_description, :image)
          .merge({ gallery_id: params[:gallery_id] })
  end
end
