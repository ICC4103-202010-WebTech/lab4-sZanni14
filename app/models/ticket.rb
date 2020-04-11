class Ticket < ApplicationRecord
  belongs_to :order
  belongs_to :ticket_type

  after_destroy :update_stats_tickets_destroyed
  after_create :update_stats_tickets_sold

  private

    def update_stats_tickets_destroyed
      event_stats = self.ticket_type.event.event_stat
      event_stats.tickets_sold-=1
      event_stats.attendance-=1
      event_stats.save!
    end

    def update_stats_tickets_sold
      event_stats = self.ticket_type.event.event_stat
      event_stats.tickets_sold+=1
      event_stats.attendance+=1
      event_stats.save!
    end

      #def check_tickets_sold
      #event_stats=self.ticket_type.event.event_stat
      #event_venue=self.ticket_type.event.event_venue

      #if event_stats.tickets_sold>event_venue.capacity
      # errors.add(:base, "Tickets sold are more than the venue capacity")
      #end

      #end

end
