module Gingerr
  module PanelsHelper
    def full_width_panel(title:, icon:)
      render layout: 'gingerr/shared/full_width_panel', locals: { title: title, icon: icon } do
        yield
      end
    end
  end
end
