using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Garage.Data.Servises;
using Garage.Data.Entities;
using System.Text;
using System.Data;
using System.IO;
using System.Threading.Tasks;

namespace Garage.API.Utils
{
    public static class ExportOfData
    {
        public static bool Export(string destFilePath,  IEnumerable<Query> lists)
        {
            // Initilization  
            bool isSuccess = false;
            StreamWriter sw = null;

            try
            {
                // Initialization.  
                StringBuilder stringBuilder = new StringBuilder();

                //var header = typeof(Query).GetProperties();

                // Saving Column header.  
                stringBuilder.Append(string.Join(",", typeof(Query).GetProperties().Select(name => name.Name).ToList()) + "\n");

                // Saving rows.  
                //lists.ForEach(row => stringBuilder.Append(string.Join(",", row) + "\n"));

                // Initialization.  
                string fileContent = stringBuilder.ToString();
                sw = new StreamWriter(new FileStream(destFilePath+"\\"+DateTime.Now.ToString().Replace(" ","").Replace(".", "").Replace(":", "") + ".csv", FileMode.Create, FileAccess.Write));

                // Saving.  
                sw.Write(fileContent);

                // Settings.  
                isSuccess = true;
            }
            catch (Exception ex)
            {
                // Info.  
                throw ex;
            }
            finally
            {
                // Closing.  
                sw.Flush();
                sw.Dispose();
                sw.Close();
            }

            // Info.  
            return isSuccess;
        }

    }

}

