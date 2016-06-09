require 'rails_helper'

describe "shared/_friend_buttons.html.erb" do
  let(:user){ create(:user_with_posts) }
  let(:user2){ create(:user) }
  let(:user3){ create(:user) }

  before do
    @user = user
    friend = create(:friend, requester_id: user2.id, accepter_id: user.id)
    def view.other_user
      @user
    end
    def view.size
      'btn-sm'
    end
  end

  context "when friends" do
    before do
      @second_user = user2
      def view.current_user
        @second_user
      end
    end

    it 'shows unfriend button' do
      render
      expect(rendered).to have_selector("a", :text => "Remove Friend")
    end
  end

  context "when not friends" do
    before do
      @third_user = user3
      def view.current_user
        @third_user
      end
    end

    it 'shows friend button' do
      render
      expect(rendered).to have_selector("a", :text => "Add Friend")
    end
  end

  context "when self" do
    before do
      @user = user
      def view.current_user
        @user
      end
    end

    it 'shows no friending button' do
      render
      expect(rendered).not_to have_selector("a", :text => "Remove Friend")
      expect(rendered).not_to have_selector("a", :text => "Add Friend")
    end
  end
end