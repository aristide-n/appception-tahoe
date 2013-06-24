require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe TimelinesController do

  # This should return the minimal set of attributes required to create a valid
  # Timeline. As you add validations to Timeline, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "dump_file" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TimelinesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all timelines as @timelines" do
      timeline = Timeline.create! valid_attributes
      get :index, {}, valid_session
      assigns(:timelines).should eq([timeline])
    end
  end

  describe "GET show" do
    it "assigns the requested timeline as @timeline" do
      timeline = Timeline.create! valid_attributes
      get :show, {:id => timeline.to_param}, valid_session
      assigns(:timeline).should eq(timeline)
    end
  end

  describe "GET new" do
    it "assigns a new timeline as @timeline" do
      get :new, {}, valid_session
      assigns(:timeline).should be_a_new(Timeline)
    end
  end

  describe "GET edit" do
    it "assigns the requested timeline as @timeline" do
      timeline = Timeline.create! valid_attributes
      get :edit, {:id => timeline.to_param}, valid_session
      assigns(:timeline).should eq(timeline)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Timeline" do
        expect {
          post :create, {:timeline => valid_attributes}, valid_session
        }.to change(Timeline, :count).by(1)
      end

      it "assigns a newly created timeline as @timeline" do
        post :create, {:timeline => valid_attributes}, valid_session
        assigns(:timeline).should be_a(Timeline)
        assigns(:timeline).should be_persisted
      end

      it "redirects to the created timeline" do
        post :create, {:timeline => valid_attributes}, valid_session
        response.should redirect_to(Timeline.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved timeline as @timeline" do
        # Trigger the behavior that occurs when invalid params are submitted
        Timeline.any_instance.stub(:save).and_return(false)
        post :create, {:timeline => { "dump_file" => "invalid value" }}, valid_session
        assigns(:timeline).should be_a_new(Timeline)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Timeline.any_instance.stub(:save).and_return(false)
        post :create, {:timeline => { "dump_file" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested timeline" do
        timeline = Timeline.create! valid_attributes
        # Assuming there are no other timelines in the database, this
        # specifies that the Timeline created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Timeline.any_instance.should_receive(:update_attributes).with({ "dump_file" => "MyString" })
        put :update, {:id => timeline.to_param, :timeline => { "dump_file" => "MyString" }}, valid_session
      end

      it "assigns the requested timeline as @timeline" do
        timeline = Timeline.create! valid_attributes
        put :update, {:id => timeline.to_param, :timeline => valid_attributes}, valid_session
        assigns(:timeline).should eq(timeline)
      end

      it "redirects to the timeline" do
        timeline = Timeline.create! valid_attributes
        put :update, {:id => timeline.to_param, :timeline => valid_attributes}, valid_session
        response.should redirect_to(timeline)
      end
    end

    describe "with invalid params" do
      it "assigns the timeline as @timeline" do
        timeline = Timeline.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Timeline.any_instance.stub(:save).and_return(false)
        put :update, {:id => timeline.to_param, :timeline => { "dump_file" => "invalid value" }}, valid_session
        assigns(:timeline).should eq(timeline)
      end

      it "re-renders the 'edit' template" do
        timeline = Timeline.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Timeline.any_instance.stub(:save).and_return(false)
        put :update, {:id => timeline.to_param, :timeline => { "dump_file" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested timeline" do
      timeline = Timeline.create! valid_attributes
      expect {
        delete :destroy, {:id => timeline.to_param}, valid_session
      }.to change(Timeline, :count).by(-1)
    end

    it "redirects to the timelines list" do
      timeline = Timeline.create! valid_attributes
      delete :destroy, {:id => timeline.to_param}, valid_session
      response.should redirect_to(timelines_url)
    end
  end

end
