global class SandboxTaskAutomation implements SandboxPostCopy
{
	global void runApexClass(SandboxContext context)
	{
		resetActiveAdminUserEmails();
	}

	global static void resetActiveAdminUserEmails()
	{
		// retrieve active admin users
		List<User> adminUsers = [SELECT Id, Email, IsActive From User WHERE Profile.Name = 'System Administrator' AND IsActive = true];

		// instantiate new list for users to update
		List<User> usersToUpdate = new List<User>();

		// iterate over active admin users to determine if email contains example.com
		for(User u : adminUsers)
		{
			if(u.Email.endsWithIgnoreCase('example.com'))
			{
				// clean up the email address, add user to collection for update
				u.Email = u.Email.replace('@example.com', '').replace('=', '@');
				usersToUpdate.add(u);
			}
		}

		// check if list has items, and if so update
		if(!usersToUpdate.isEmpty())
		{
			update usersToUpdate;
		}
	}
}