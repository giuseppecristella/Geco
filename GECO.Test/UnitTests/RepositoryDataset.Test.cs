using System;
using Geco.Dataset.DataSet1TableAdapters;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace GECO.Test.UnitTests
{
  [TestClass]
  public class RepositoryDatasetTest
  {
    [TestMethod]
    public void GetEventiHome()
    {

      NewsTableAdapter taNews = new NewsTableAdapter();

      var filledDataset = taNews.GetEventiHome("1");

    }
  }
}
