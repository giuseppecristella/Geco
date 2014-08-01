#region

using System.Linq;
using GECO.DomainClasses;
 

#endregion

namespace Repository
{
    /// <summary>
    /// Extending the IRepository<Customer>
    /// </summary>
    //public static class CustomerRepository
    //{
    //    public static decimal GetCustomerOrderTotalByYear(
    //        this IRepository<Content> customerRepository, 
    //        int customerId, int year)
    //    {
    //        return customerRepository
    //            .FindById(customerId)
    //            .Orders.SelectMany(o => o.OrderDetails)
    //            .Select(o => o.Quantity*o.UnitPrice).Sum();
    //    }

    //    public static void AddCustomerWithAddressValidation(
    //        this IRepository<Content> customerRepository, Customer customer)
    //    {
    //        //USPSManager m = new USPSManager("YOUR_USER_ID", true);
    //        //Address a = new Address();
    //        //a.Address1 = customer.Address;
    //        //a.City = customer.City;

    //        //Address validatedAddress = m.ValidateAddress(a);

    //        //if (validatedAddress != null)
    //        customerRepository.InsertGraph(customer);
    //    }
    //}
}