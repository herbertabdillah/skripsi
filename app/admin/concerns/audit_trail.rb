module AuditTrail
  def self.extended(base)
    base.instance_eval do
      collection_action :audit_trail do
        render 'audit_trail'
      end

      action_item :audit_trail, only: :show do
        link_to 'Versions', action: 'audit_trail', params: { class: resource.class.name, id: resource.id }
      end
    end
  end
end
