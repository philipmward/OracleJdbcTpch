import java.sql.*;
import oracle.jdbc.*;

import java.awt.*;
import java.awt.event.*;
import java.math.RoundingMode;

import javax.swing.*;
import javax.swing.border.*;
import javax.swing.event.*;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Philip Ward
 */

public class LoginOracleASU extends JFrame
{
	static final String url = "jdbc:oracle:thin:@acaddb2.asu.edu:1521:orcl";

	protected JTextField user_txt;
	protected JPasswordField passwd_txt;

	private String userName;
	private String pwd;
	private Connection conn;
		

	public LoginOracleASU()
	{
		super("Login Dialog");
		setSize(400, 130);
		
		JPanel p11 = new JPanel();
		p11.setLayout(new GridLayout(2, 1, 5, 5));
		p11.setBorder(new EmptyBorder(10, 10, 10, 5));
		
		p11.add(new JLabel("User Name:"));
		p11.add(new JLabel("Password:"));
		
		JPanel p12 = new JPanel();
		p12.setLayout(new GridLayout(2, 1, 5, 5));
		p12.setBorder(new EmptyBorder(10, 5, 10, 10));
		
		user_txt = new JTextField();
		passwd_txt = new JPasswordField();
		
		p12.add(user_txt);
		p12.add(passwd_txt);
		
		JPanel p1 = new JPanel(new BorderLayout());
		p1.add(p11, BorderLayout.WEST);
		p1.add(p12, BorderLayout.CENTER);
		
		getContentPane().add(p1, BorderLayout.NORTH);
		
		JPanel p2 = new JPanel();
		JPanel p21 = new JPanel(new GridLayout(1, 2, 5, 5));
		
		JButton ok_btn = new JButton("Ok");
		ok_btn.setMnemonic('O');
		ok_btn.setActionCommand("ok");
		ok_btn.addActionListener(new ButtonClickHandler());
		getRootPane().setDefaultButton(ok_btn);
		p21.add(ok_btn);
		
		JButton cancel_btn = new JButton("Close");
		cancel_btn.setMnemonic('C');
		cancel_btn.setActionCommand("close");
		cancel_btn.addActionListener(new ButtonClickHandler());
		
		p21.add(cancel_btn);
		p2.add(p21);
		
		getContentPane().add(p2);
		
		Dimension dim = getToolkit().getScreenSize();
		setLocation(dim.width/2 - getWidth()/2, dim.height/2 - getHeight()/2);
		
		WindowListener wndCloser = new WindowAdapter() {
			public void windowClosing(WindowEvent e) {
				System.exit(0);
			}
		};
		addWindowListener(wndCloser);
		
		setVisible(true);
	}



	class ButtonClickHandler implements ActionListener
	{
		public void actionPerformed(ActionEvent e) 
		{
			String passwd = new String(passwd_txt.getPassword());
				
			//press "OK" button in LogIn window
			if (e.getActionCommand().equals("ok"))
			{
				if (user_txt.getText().equals("") || passwd.equals(""))
				{
					JOptionPane.showMessageDialog(null, "User name and password are required!",
					"Log In Error", JOptionPane.ERROR_MESSAGE);
				}
				else
				{
					userName = user_txt.getText();
					pwd = passwd;
										
					try
					{		
						System.out.println ("Loading Oracle driver");
			
						DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
						conn = DriverManager.getConnection(url,userName, pwd);
			
						System.out.println ("Connected to the Oracle database");

						// Execute Queries!!
						executeQueries();

						conn.close();
						System.out.println();
						System.out.println("Connection closed.");
						
					}
	
					catch(SQLException sqlE)
					{
						sqlE.printStackTrace();
					}
				}
			}
			else // press "Close" button 
			{
				System.exit(0);
			}
		}
	}
	
	public void executeQueries()
	{
		try
		{
		System.out.println("\n" + "Oracle and JDBC Project 1" + "\n" + "By: Philip Ward");
		Statement stmt = conn.createStatement();
		ResultSet rs = null;

                //get and print table and view metadata
                
                DatabaseMetaData dbmd;
                dbmd = conn.getMetaData();
                rs = dbmd.getTables (null, userName.toUpperCase(), null, new String[] {"TABLE", "VIEW"});
                ResultSet dbmdTableColumns=null;
                while (rs.next())
                    {
                        String tableName = rs.getString("TABLE_NAME");
                        String tableType = rs.getString("TABLE_TYPE");
                        System.out.println("\n" + tableType + " " + tableName);
                        
             
                        /* checks if it’s a user-defined table*/
                        if (tableType.equals("TABLE"))
                        /* Get the column names in the ResultSet */
                        dbmdTableColumns = dbmd.getColumns(null,null,tableName,null);
                        while (dbmdTableColumns.next())
                        { 	/* get the attribute names and types */
                            String columnName = dbmdTableColumns.getString("COLUMN_NAME") ;
                            String columnType = dbmdTableColumns.getString("TYPE_NAME") ;
                            System.out.println("    " + columnType + " " + columnName);
                        }
                        
                    }
                
                //create and execute statements
                System.out.println("\n" + "Query 1: Which customers have never placed an urgent order?" + "\n");
                rs=stmt.executeQuery("select C.c_name as customerName, C.c_phone as phone, C.c_acctbal as accountBalance, C.c_mktsegment as marketSegment from customersWithOrder C where not exists(select * from customerWithUrgentOrder U where U.C_CUSTKEY = C.c_custkey) order by C.c_name");
                System.out.printf("customerName%-2s", " ");
		System.out.printf(" phone%-12s", " ");
		System.out.printf(" accountBalance%-5s", " ");
		System.out.println(" marketSegment ");
                
                while (rs.next()) 
			{
			System.out.printf("%-15s", rs.getString(1));
                        System.out.printf("%-18s", rs.getString(2));
			System.out.printf("%-20s", rs.getBigDecimal(3).setScale(2, RoundingMode.CEILING));
                        System.out.println(rs.getString(4));
			}
                
                System.out.println("\n" + "Query 2: Which orders have only one line item?" + "\n");
                rs=stmt.executeQuery("select O.o_orderkey as orderKey, O.o_custkey as customerKey, O.o_orderdate as orderDate, O.o_totalprice as orderTotal from lineItem L, orders O where O.o_orderkey = L.l_orderkey group by O.o_orderkey, O.o_custkey, O.o_orderdate, O.o_totalprice having count(L.l_linenumber)=1 order by O.o_orderdate");
                System.out.printf("orderKey%-2s", " ");
		System.out.printf(" customerKey%-6s", " ");
		System.out.printf(" orderDate%-7s", " ");
		System.out.println(" orderTotal ");
                
                while (rs.next()) 
			{
			System.out.printf("%-15s", rs.getInt(1));
                        System.out.printf("%-14s", rs.getString(2));
			System.out.printf("%-17s", rs.getString(3));
                        System.out.println(rs.getBigDecimal(4).setScale(2, RoundingMode.CEILING));
			}
		
                System.out.println("\n" + "Query 3a: Which Suppliers supply parts with a supply cost > 800?" + "\n");
                
                String getSupplyCostQuery = "select S.s_name as supplierName, PS.ps_partkey as partkey, PS.ps_supplycost as supplyCost"
                    +" from Partsupp PS, supplier S"
                    +" where PS.ps_suppkey = S.s_suppkey"
                    +" group by S.s_name, PS.ps_partkey, PS.ps_supplycost"
                    +" having PS.ps_supplycost > ?"
                    +" order by PS.ps_supplycost DESC";
                PreparedStatement pdst = conn.prepareStatement(getSupplyCostQuery);
                pdst.setString(1, "800");
                rs=pdst.executeQuery();
                System.out.printf("supplierName%-6s", " ");
                System.out.printf(" partKey %-4s", " ");
                System.out.println(" supplyCost");
                
                while (rs.next())
                {
                    System.out.printf("%-19s", rs.getString(1));
                    System.out.printf("%-13s", rs.getInt(2));
                    
                    System.out.println(rs.getBigDecimal(3).setScale(2, RoundingMode.CEILING));
                    
                }
                
                
                System.out.println("\n" + "Query 3b: Which Suppliers supply parts with a supply cost > 900?" + "\n");
                
                pdst.setString(1, "900");
                rs=pdst.executeQuery();
                System.out.printf("supplierName%-6s", " ");
                System.out.printf(" partKey %-4s", " ");
                System.out.println(" supplyCost");
                
                while (rs.next())
                {
                    System.out.printf("%-19s", rs.getString(1));
                    System.out.printf("%-13s", rs.getInt(2));
                    System.out.println(rs.getBigDecimal(3).setScale(2, RoundingMode.CEILING));
                    
                }
		}
                
                
               
		catch(SQLException sqlE)
		{
			sqlE.printStackTrace();
		}
	}
	
}
