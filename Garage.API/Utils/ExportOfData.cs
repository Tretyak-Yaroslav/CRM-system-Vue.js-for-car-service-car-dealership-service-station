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
using System.Text.RegularExpressions;

namespace Garage.API.Utils
{
    public static class ExportOfData
    {
        public static bool Export(string destFilePath,  IEnumerable<Query> lists)
        {
            // Initilization  
            bool isSuccess = false;
            StreamWriter sw = null;
            Regex rgx = new Regex("[#,]");

            try
            {
                // Initialization.  
                StringBuilder stringBuilder = new StringBuilder();
                StringBuilder stringBuilderForRows = new StringBuilder();

                // Saving Column header.  
                stringBuilder.Append(string.Join(";", typeof(Query).GetProperties().Select(name => name.Name).ToList()) + "\n");

                // Saving rows.  
                foreach (Query item in lists)
                {
                    stringBuilderForRows.Append(string.Join(";", typeof(Query).GetProperties().Select(name => name.GetValue(item)).ToList()) + "\n");
                }

                //Delete specific symbols
                string cleanRowValues = rgx.Replace(stringBuilderForRows.ToString(), "");
                stringBuilder.Append(string.Join(";", cleanRowValues));

                // Getting id.
                int id = lists.Select(item => item.ItemID).FirstOrDefault();

                // Initialization.  
                string fileContent = stringBuilder.ToString();
                string fileName = destFilePath + "\\" + id + "_" + DateTime.Now.ToString().Replace(" ", "").Replace(".", "").Replace(":", "").Replace("/", "") + ".csv";
                sw = new StreamWriter(new FileStream(fileName, FileMode.Create, FileAccess.Write), Encoding.UTF8);

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

