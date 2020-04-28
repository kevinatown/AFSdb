# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

AccountType.import('./tables/AccountTypesT.xlsx')
# AfsAccount.import('./tables/AFSAccounts.xlsx')
# BuildingType.import('./tables/BuildingTypesT.xlsx')
# Car.import('./tables/CarsT.xlsx')
CompanyCategory.import('./tables/CompanyCategoriesT.xlsx')
ContractorCategory.import('./tables/ContractorCategoriesT.xlsx')
# County.import('./tables/CountiesT.xlsx')
# EmploymentType.import('./tables/EmploymentTypeT.xlsx')
EventType.import('./tables/EventTypesT.xlsx')
ExpenseType.import('./tables/ExpenseTypesT.xlsx')
HeatFuel.import('./tables/HeatFuelsT.xlsx')
HeatType.import('./tables/HeatTypesT.xlsx')
JobCategory.import('./tables/JobCategoriesT.xlsx')
JobSubcategory.import('./tables/JobSubcategories.xlsx')
# # PayeeType.import('./tables/PayeeTypesT.xlsx')
State.import('./tables/us_states.xlsx')
Streetdir.import('./tables/StreetDirT.xlsx')
StreetType.import('./tables/StreetTypeT.xlsx')
WasteSystem.import('./tables/WasteSystemsT.xlsx')
WaterSource.import('./tables/WaterSourcesT.xlsx')
# # Client.import('./tables/ClientsT.xlsx')
# # Contact.import('./tables/ContactsT.xlsx')
# Contractor.import('./tables/ContractorsT.xlsx')
# # Property.import('./tables/PropertiesT.xlsx')
# # Staff.import('./tables/StaffT.xlsx')
# # Driver.import('./tables/StaffT.xlsx')
# # Payee.import('./tables/PayeesT.xlsx')
# # Job.import('./tables/JobsT.xlsx')
# # AccountsPayable.import('./tables/AccountsPayableT.xlsx')
# Calendar.import('./tables/CalendarT.xlsx')
# Expense.import('./tables/ExpensesT.xlsx')
# TimeClock.import('./tables/TimeClockT.xlsx')
Staff.create!( f_name:'Kevin', m_name: 'A', l_name: 'Townsend',
	          				city: 'Somewhere', zip: '12345', phone: '(555) 555-5222',
	          				street_name: 'Somewhere', street_number: '123', hire_date: DateTime.now,
	          				hourly_wage: 5.50, street_type_id: 1, state_id: 46, is_admin: 1
	          				)
Staff.create!( f_name:'David', m_name: 'A', l_name: 'Lidz',
	          				city: 'Somewhere', zip: '12345', phone: '(444) 444-4444',
	          				street_name: 'Somewhere', street_number: '123', hire_date: DateTime.now,
	          				street_type_id: 1, state_id: 20, is_admin: 1
	          				)
# kevin = User.create!(email: "kevinatown@gmail.com", password: "password",
#                      password_confirmation: "password", is_admin: 1, staff_id: kevins.id)

# david = User.create!(email: "davidlidz@yahoo.com", password: "password",
                     # password_confirmation: "password", is_admin: 0, staff_id: 3)

