class ProfilesController < ApplicationController
  version(20140501) do
    render json: {
      name: "John Doe",
    }
  end

  version(20140611) do
    render json: {
      first_name: "John",
      last_name: "Doe"
    }
  end
end
