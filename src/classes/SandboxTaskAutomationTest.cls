@isTest
public class SandboxTaskAutomationTest
{
	static testMethod void testResetActiveAdminUserEmails()
	{
		// set up required parameters for testSandboxPostCopyScript
		SandboxTaskAutomation sandTaskAuto = new SandboxTaskAutomation();
		Id orgId = UserInfo.getOrganizationId();
		Id sandboxId = UserInfo.getOrganizationId();
		String sandboxName = 'sand';

		// ensure we have a user with email that shoudl be reformatted
		Profile admin = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
		User adminUser = new User();
		adminUser.ProfileId = admin.Id;
		adminUser.FirstName = 'Test';
		adminUser.LastName = 'Test';
		adminUser.Alias = 'test';
		adminUser.TimezoneSidKey = 'America/New_York';
		adminUser.LanguageLocaleKey = 'en_US';
		adminUser.LocaleSidKey = 'en_US';
		adminUser.EmailEncodingKey = 'UTF-8';
		adminUser.Email = 'test.test=' + orgId + '.com@example.com';
		adminUser.Username = 'test.test@' + orgId + '.com';
		
		insert adminUser;
		
		// run test
		Test.startTest();
		Test.testSandboxPostCopyScript(sandTaskAuto, orgId, sandboxId, sandboxName);
		Test.stopTest();
	}
}