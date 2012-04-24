class Admin::FertilisersController < Admin::BaseController
  # GET /fertilisers
  # GET /fertilisers.json
  def index
    @fertilisers = Fertiliser.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fertilisers }
    end
  end

  # GET /fertilisers/new
  # GET /fertilisers/new.json
  def new
    @fertiliser = Fertiliser.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fertiliser }
    end
  end

  # GET /fertilisers/1/edit
  def edit
    @fertiliser = Fertiliser.find(params[:id])
  end

  # POST /fertilisers
  # POST /fertilisers.json
  def create
    @fertiliser = Fertiliser.new(params[:fertiliser])

    respond_to do |format|
      if @fertiliser.save
        format.html { redirect_to admin_fertilisers_path, notice: 'Fertiliser was successfully created.' }
        format.json { render json: @fertiliser, status: :created, location: @fertiliser }
      else
        format.html { render action: "new" }
        format.json { render json: @fertiliser.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fertilisers/1
  # PUT /fertilisers/1.json
  def update
    @fertiliser = Fertiliser.find(params[:id])

    respond_to do |format|
      if @fertiliser.update_attributes(params[:fertiliser])
        format.html { redirect_to admin_fertilisers_path, notice: 'Fertiliser was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @fertiliser.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fertilisers/1
  # DELETE /fertilisers/1.json
  def destroy
    @fertiliser = Fertiliser.find(params[:id])
    @fertiliser.destroy

    respond_to do |format|
      format.html { redirect_to admin_fertilisers_path, notice: 'Fertiliser was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
