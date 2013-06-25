class TimelinesController < ApplicationController
  # GET /timelines
  # GET /timelines.json
  def index
    @timelines = Timeline.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @timelines }
    end
  end

  # GET /timelines/1
  # GET /timelines/1.json
  def show
    @timeline = Timeline.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @timeline }
    end
  end

  # GET /timelines/new
  # GET /timelines/new.json
  def new
    @timeline = Timeline.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @timeline }
    end
  end

  # GET /timelines/1/edit
  def edit
    @timeline = Timeline.find(params[:id])
  end

  # POST /timelines
  # POST /timelines.json
  def create
    @timeline = Timeline.new(params[:timeline])

    respond_to do |format|
      if @timeline.save
        format.html { redirect_to @timeline, notice: 'Timeline was successfully created.' }
        format.json { render json: @timeline, status: :created, location: @timeline }
      else
        format.html { render action: "new" }
        format.json { render json: @timeline.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /timelines/1
  # PUT /timelines/1.json
  def update
    @timeline = Timeline.find(params[:id])

    respond_to do |format|
      if @timeline.update_attributes(params[:timeline])
        format.html { redirect_to @timeline, notice: 'Timeline was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @timeline.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /timelines/1
  # DELETE /timelines/1.json
  def destroy
    @timeline = Timeline.find(params[:id])
    @timeline.destroy

    respond_to do |format|
      format.html { redirect_to timelines_url }
      format.json { head :no_content }
    end
  end
end
