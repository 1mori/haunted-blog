# frozen_string_literal: true

class BlogsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  before_action :match_login_user, only: %i[edit update destroy]
  before_action :show_secret, only: %i[show]

  def index
    @blogs = Blog.search(params[:term]).published.default_order
  end

  def show; end

  def new
    @blog = Blog.new
  end

  def edit; end

  def create
    @blog = current_user.blogs.new(blog_params)

    if @blog.save
      redirect_to blog_url(@blog), notice: 'Blog was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @blog.update(blog_params)
      redirect_to blog_url(@blog), notice: 'Blog was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog.destroy!

    redirect_to blogs_url, notice: 'Blog was successfully destroyed.', status: :see_other
  end

  private

  def blog_params
    allow_params = %i[title content secret]
    allow_params << :random_eyecatch if current_user.premium?
    params.require(:blog).permit(*allow_params)
  end

  def match_login_user
    @blog = Blog.find_by!(id: params[:id], user_id: current_user.id)
  end

  def show_secret
    @blog = if current_user
              Blog.where(id: params[:id]).where('secret = ? OR user_id = ?', false, current_user.id).first!
            else
              Blog.find_by!(id: params[:id], secret: false)
            end
  end
end
