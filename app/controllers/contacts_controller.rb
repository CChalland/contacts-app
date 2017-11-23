class ContactsController < ApplicationController
  def index
    contacts = Contact.all 
    if params[:search_first_name]
      contacts = contacts.where("first_name ILIKE ?", "%#{params[:search_first_name]}%")

    elsif params[:search_last_name]
      params[:search_last_name]
      contacts = contacts.where("last_name ILIKE ?", "%#{params[:search_last_name]}%")
      
    elsif params[:search_middle_name]
      contacts = contacts.where("middle_name ILIKE ?", "%#{params[:search_middle_name]}%")
    
    elsif params[:search_phone_number]
      contacts = contacts.where("phone_number ILIKE ?", "%#{params[:search_phone_number]}%")
   
    elsif params[:search_email]
      contacts = contacts.where("email ILIKE ?", "%#{params[:search_email]}%")
    end
    render json: contacts.as_json
  end

  def create
    contact = Contact.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      middle_name: params[:middle_name],
      phone_number: params[:phone_number],
      email: params[:email],
      bio: params[:bio]
      )
    if contact.save
      render json: contact.as_json
    else
      render json: {errors: contact.errors.full_messages}, status: :bad_request
    end
  end

  def show
    contact_id = params[:id]
    contact = Contact.find_by(id: contact_id)
    render json: contact.as_json
  end

  def update
    contact_id = params[:id]
    contact = Contact.find_by(id: contact_id)
    contact.first_name = params[:first_name] || contact.first_name
    contact.last_name = params[:last_name] || contact.last_name
    contact.middle_name = params[:middle_name] || contact.middle_name
    contact.phone_number = params[:phone_number] || contact.phone_number
    contact.email = params[:email] || contact.email
    contact.bio = params[:bio] || contact.bio
    if contact.save
      render json: contact.as_json
    else
      render json: {errors: contact.errors.full_messages}, status: :bad_request
    end
  end

  def destroy
    contact_id = params[:id]
    contact = Contact.find_by(id: contact_id)
    contact.destroy
    render json: {message: "You have destroy this contact"}
  end
end