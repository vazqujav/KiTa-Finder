class KitasController < ApplicationController
  # GET /kitas
  def index
    @my_address = ""
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  # POST /result
  def search
    my_loc = GeoKit::Geocoders::GoogleGeocoder.geocode(params[:my_address])
    if my_loc.success   
      @my_loc = my_loc
      @my_address = params[:my_address]
      @kitas = Kita.search(@my_loc, params[:page])    
      render :action => 'index'
    else
      flash[:error] = 'Die Adresse \"#{params[:my_address]}\" wurde nicht gefunden.'
      redirect_to root_url
    end
  end

  # GET /kitas/1
  def show
    @kita = Kita.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /kitas/new
  def new
    @kita = Kita.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /kitas/1/edit
  def edit
    @kita = Kita.find(params[:id])
  end

  # POST /kitas
  def create
    @kita = Kita.new(params[:kita])

    respond_to do |format|
      if @kita.save
        flash[:notice] = 'Kita was successfully created.'
        format.html { redirect_to(@kita) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /kitas/1
  def update
    @kita = Kita.find(params[:id])

    respond_to do |format|
      if @kita.update_attributes(params[:kita])
        flash[:notice] = 'Kita was successfully updated.'
        format.html { redirect_to(@kita) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /kitas/1
  def destroy
    @kita = Kita.find(params[:id])
    @kita.destroy

    respond_to do |format|
      format.html { redirect_to(kitas_url) }
    end
  end
  
  def no_kita
    Kita.find(params[:id]).set_no_kita_vote
    redirect_to :back
  end
  
  # scrape data from kinderkrippen-online.ch
  def kita_scrape
    Kita.kita_scrape
    redirect_to root_url
  end
  
  # scrape data from http://yellow.local.ch/de/q/Kinderkrippe,%20Kinderhort.html#start=0
  def yp_scrape
    Kita.yp_scrape
    redirect_to root_url
  end
  
end
