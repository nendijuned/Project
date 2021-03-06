﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;

namespace PLNLite.Presentation.Components
{
    public class BasicScripts
    {
        //type your basic script here, not to retype on each page, it is not based on clean code.
        private static String SetMetaScript()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<meta charset='utf-8'>                                                        ");
            sb.Append("<meta name='viewport' content='width=device-width, initial-scale=1.0'>        ");
            sb.Append("<meta name='description' content=''>                                          ");
            sb.Append("<meta name='allanprakosa' content='templateforbioapps'>                       ");
            sb.Append("<link rel='shortcut icon' href='../../Scripts/UserPanel/images/favicon.html'> ");

            return sb.ToString();
        }
        public static String GetMetaScript()
        {
            return SetMetaScript();
        }

    }
}