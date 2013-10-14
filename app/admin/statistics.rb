ActiveAdmin.register_page "Statistics" do

  menu :priority => 1, :label => 'Statistics'

  content :title => 'Statistics'do
    @users = User.select([:id, :email]).includes(:events).all
    @events = Event.all
    columns do
      column do
        panel "User activity statistic" do
          table class: 'events-table' do     #.events-table{align: 'center'}
            thead do
              tr do
                th do
                  'User'
                end
                th colspan: 5 do
                  'Events'
                end
              end
            end
            tbody do
              @users.each do |user|
                tr do
                  td do
                    user.email
                  end
                  @events.each do |event|
                    td do
                      user_events = user.events.uniq        #  FIXME: переделать чтобы брать из базы названия эвентов юзера через ДИСТИНКТ, а не ВЫБИРАТЬ ВСЕ, а потом ЮНИК
                      user_events_names = []
                      user_events.each { |e| user_events_names << e.name }
                      if user_events_names.include?(event.name)
                        link_to event.name, event_path(user_id: user.id, event_name: event.name)
                      else
                        event.name
                      end
                    end
                  end
                end
              end
            end
          end
         end
       end
    end
  end  #content


end
