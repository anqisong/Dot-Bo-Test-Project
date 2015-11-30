require 'EasyPost'

EasyPost.api_key = 'wt1maH0EXRZzo76ol53hdg'

class Api::ShipmentsController < ApplicationController
    
  def shipment_params
    params.require(:shipment).permit(:to_address, :from_address, :weight, :length, :width, :height)
  end
  
  def create
    EasyPost.api_key = Rails.application.secrets.easypost_api_key
    
    parcel = EasyPost::Parcel.create(
      :width => shipment_params[:width],
      :length => shipment_params[:length],
      :height => shipment_params[:height],
      :weight => shipment_params[:weight]
    )
    
    customs_item = EasyPost::CustomsItem.create(
      :description => 'Furniture',
      :quantity => 2,
      :value => 100,
      :weight => 10,
      :hs_tariff_number => 610910,
      :origin_country => 'US',
    )
    
    customs_info = EasyPost::CustomInfo.create(
      :eel_pfc => 'NOEEI 30.37(a)',
      :customs_certify => true,
      :customs_signer => 'Jarrett Streebin',
      :contents_type => 'gift',
      :customs_items => [customs_item]
    )
    
    shipment = EasyPost::Shipment.create(
      :to_address => {id: shipment_params[:to_address]},
      :from_address => {id: shipment_params[:from_address]},
      :parcel => parcel,
      :customs_info => customs_info
    )
    
    shipment.buy(
      :rate => shipment.lowest_rate(carriers = ['USPS'], services = ['First'])
    )
    
    render json: shipment.postage_label.label_url
    
    puts shipment.postage_label.label_url
    
    redirect_to shipment.postage_label.label_url
  end

end
