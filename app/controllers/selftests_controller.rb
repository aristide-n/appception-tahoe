class SelftestsController < ApplicationController
  # GET /selftests
  # GET /selftests.json
  def index
    @selftests = Selftest.all
    @unique_tests = (Selftest.select(:name).uniq)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @selftests }
    end
  end

  def opChart
    @cssTests = Selftest.where(name: params[:name]);

    respond_to do |format|
      format.html # opChart.html.erb
    end

  end
  # GET /selftests/1
  # GET /selftests/1.json
  def show
    @selftest = Selftest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @selftest }
    end
  end

  # GET /selftests/new
  # GET /selftests/new.json
  def new
    @selftest = Selftest.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @selftest }
    end
  end

  # GET /selftests/1/edit
  def edit
    @selftest = Selftest.find(params[:id])
  end

  # POST /selftests
  # POST /selftests.json
  def create
    @selftest = Selftest.new(params[:selftest])

    respond_to do |format|
      if @selftest.save
        format.html { redirect_to @selftest, notice: 'Selftest was successfully created.' }
        format.json { render json: @selftest, status: :created, location: @selftest }
      else
        format.html { render action: "new" }
        format.json { render json: @selftest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /selftests/1
  # PUT /selftests/1.json
  def update
    @selftest = Selftest.find(params[:id])

    respond_to do |format|
      if @selftest.update_attributes(params[:selftest])
        format.html { redirect_to @selftest, notice: 'Selftest was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @selftest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /selftests/1
  # DELETE /selftests/1.json
  def destroy
    @selftest = Selftest.find(params[:id])
    @selftest.destroy

    respond_to do |format|
      format.html { redirect_to selftests_url }
      format.json { head :no_content }
    end
  end
end
