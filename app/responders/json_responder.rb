class JsonResponder < ActionController::Responder
  protected

  def api_behavior(error)
    raise error unless resourceful?

    if put? || patch?
      display resource, :status => :ok
    else
      super
    end
  end
end
