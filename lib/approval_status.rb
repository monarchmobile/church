class ApprovalStatus

	def initialize(role)
		@role = role
	end

	def other_roles
		roles = %w[:admin :coordinator :intercessor]
		o_roles = roles.map { |x| !x == @role }
	end

	def query(key)

		query = {
			"#{@role.to_s}_waiting": User.not_approved.with_role(role_id(@role)).without_role(role_ids(other_roles))
			"#{@role.to_s}_approved": User.approved.with_role(role_ids(@role))
		}

		query[key]

	end
end


# find all admins that are _waiting

# find all coordinators that are waiting, that are not admins or intercessors

# find all ints, that are not admins or coors