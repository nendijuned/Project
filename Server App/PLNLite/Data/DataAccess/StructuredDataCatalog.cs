﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PLNLite.Data.DataAgent;
using PLNLite.Entity.Object;
using System.Data.SqlClient;
using System.Text;
using System.Web.Configuration;

namespace PLNLite.Data.DataAccess
{
    public class StructuredDataCatalog : DatabaseFactory
    {
        public static List<Menu> GetMenus(string PERNR)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                                                                       ");
            query.Append(" MN.MENID, MN.MENAM, MN.MNURL,                                                ");
            query.Append(" MN.MNPID, MN.MNSEQ, MN.MNICO                                                 ");
            query.Append(" FROM                                                                         ");
            query.Append(" biocustomercare.USER_OTORITY OT,                                             ");
            query.Append(" biocustomercare.ROLE_MENU_RELATION RM,                                       ");
            query.Append(" biocustomercare.USER_ROLE RL,                                                ");
            query.Append(" biocustomercare.USER_MENU MN                                                 ");
            query.Append(" WHERE OT.ROLID = RL.ROLID                                                    ");
            query.Append(" AND RM.ROLID = OT.ROLID AND RM.MENID = MN.MENID                              ");
            query.Append(" AND MN.BEGDA <= GETDATE() AND MN.ENDDA >= GETDATE()                          ");
            query.Append(" AND OT.BEGDA <= GETDATE() AND OT.ENDDA >= GETDATE()                          ");
            query.Append(" AND RL.BEGDA <= GETDATE() AND RL.ENDDA >= GETDATE()                          ");
            query.Append(" AND OT.PERNR = '" + PERNR + "'                                               ");
            query.Append(" AND RL.APPID = '" + WebConfigurationManager.AppSettings["ApplicationID"] + "'");
            query.Append(" ORDER BY MN.MNPID ASC, MN.MNSEQ ASC                                          ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            try
            {
                conn.Open();
                SqlDataReader reader = GetDataReader(cmd);
                List<Menu> menu = new List<Menu>();
                while (reader.Read())
                {
                    Menu m = new Menu();

                    m.Id = Convert.ToInt16(reader["MENID"]);
                    m.MenuName = Convert.ToString(reader["MENAM"]);
                    m.NavUrl = Convert.ToString(reader["MNURL"]);
                    m.IconClass = Convert.ToString(reader["MNICO"]);

                    if (reader["MNPID"].ToString() != "0")
                    {
                        m.Parent = new Menu();
                        m.Parent.Id = Convert.ToInt16(reader["MNPID"]);
                    }

                    menu.Add(m);
                }
                return menu;
            }
            finally
            {
                conn.Close();
                cmd.Dispose();
                conn.Dispose();
            }
        }
    }
}