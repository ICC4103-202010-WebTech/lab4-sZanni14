class Ticket < ApplicationRecord
  belongs_to :order
  belongs_to :ticket_type

  after_destroy :update_stats_tickets_destroyed
  before_create :update_stats_tickets_sold

  private

    def update_stats_tickets_destroyed
      #Se elimina el ticket, y se resta 1 a los tickets vendidos y a la asistencia del evento
      event_stats = self.ticket_type.event.event_stat
      event_stats.tickets_sold-=1
      event_stats.attendance-=1
      event_stats.save!
    end

    def update_stats_tickets_sold
      event_stats = self.ticket_type.event.event_stat
      capacity = self.ticket_type.event.event_venue.capacity

      if event_stats.tickets_sold+1 > capacity
        #Si el ticket es creado y los tickets vendidos exceden la capacidad del venue, se levanta el error
        raise "If this ticket is created, tickets sold exceed venue capacity!!"

      else
        #Si no se excede la capacidad, se crea el ticket y se aumentan los tickets vendidos y la asistencia del evento
        event_stats.tickets_sold+=1
        event_stats.attendance+=1
        event_stats.save!
      end

    end

end
