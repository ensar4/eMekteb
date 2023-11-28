using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Exceptions
{
    public class UserExceptions : Exception
    {
        public UserExceptions(string message):base(message)
        {

        }
    }
}
