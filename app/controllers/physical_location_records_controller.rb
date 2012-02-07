class PhysicalLocationRecordsController < ApplicationController
  # GET /physical_location_records
  # GET /physical_location_records.xml
  def index
    @physical_location_records = PhysicalLocationRecord.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @physical_location_records }
    end
  end

  # GET /physical_location_records/1
  # GET /physical_location_records/1.xml
  def show
    @physical_location_record = PhysicalLocationRecord.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @physical_location_record }
    end
  end

  # GET /physical_location_records/new
  # GET /physical_location_records/new.xml
  def new
    @physical_location_record = PhysicalLocationRecord.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @physical_location_record }
    end
  end

  # GET /physical_location_records/1/edit
  def edit
    @physical_location_record = PhysicalLocationRecord.find(params[:id])
  end

  # POST /physical_location_records
  # POST /physical_location_records.xml
  def create
    @physical_location_record = PhysicalLocationRecord.new(params[:physical_location_record])

    respond_to do |format|
      if @physical_location_record.save
        format.html { redirect_to(@physical_location_record, :notice => 'Physical location record was successfully created.') }
        format.xml  { render :xml => @physical_location_record, :status => :created, :location => @physical_location_record }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @physical_location_record.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /physical_location_records/1
  # PUT /physical_location_records/1.xml
  def update
    @physical_location_record = PhysicalLocationRecord.find(params[:id])

    respond_to do |format|
      if @physical_location_record.update_attributes(params[:physical_location_record])
        format.html { redirect_to(@physical_location_record, :notice => 'Physical location record was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @physical_location_record.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /physical_location_records/1
  # DELETE /physical_location_records/1.xml
  def destroy
    @physical_location_record = PhysicalLocationRecord.find(params[:id])
    @physical_location_record.destroy

    respond_to do |format|
      format.html { redirect_to(physical_location_records_url) }
      format.xml  { head :ok }
    end
  end
end
