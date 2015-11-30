require 'EasyPost'

class Api::AddressesController < ApplicationController

  def to_address
    params.require(:to_address).permit(:name, :company, :street1, :street2, :city, :state, :country, :zip, :phone)
  end
  
  def from_address
    params.require(:from_address).permit(:name, :company, :street1, :street2, :city, :state, :country, :zip, :phone)
  end
  
  def index
    @addresses = Address.all
    render json: @addresses
  end

  def create
    EasyPost.api_key = Rails.application.secrets.easypost_api_key
    
    to_address = EasyPost::Address.create(to_address)
    @to_address = Address.new(to_address)
    @to_address.easy_post_id = to_address.id
  
    from_address = EasyPost::Address.create(from_address)
    @from_address = Address.new(from_address)
    @from_address.easy_post_id = from_address.id
      
    if @address.save
      render json: @address
    else
      render json: @address.errors.full_messages, status: :unprocessable_entity
    end
  end

  def delete
    address = Address.find(params[:id])
    address.destroy
    render json: address
  end
end
