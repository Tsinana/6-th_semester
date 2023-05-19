using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace WpfCourseWork {
    /// <summary>
    /// Логика взаимодействия для ProjectSetup.xaml
    /// </summary>
    public partial class ProjectSetup : Window {
        private static MainWindow _ob;
        public ProjectSetup(MainWindow ob) {
            InitializeComponent();
            _ob = ob;
            Set_machine_parametrs();
        }

        public void Set_machine_parametrs() {
            StreamReader reader = new StreamReader("machine_paramentrs.txt");
            string all_strings = reader.ReadToEnd().Replace("\n","").Replace("\r","");
            reader.Close();
            string[] arr = all_strings.Split(' ');
            without_any_act.Text = arr[0];
            max_temperature.Text = arr[1];
            a.Text = arr[2];
}
        private void Esc_Click(object sender, RoutedEventArgs e) {
            Close();
        }
        private void Ok_Click(object sender, RoutedEventArgs e) {
            StreamWriter sw = new StreamWriter($"machine_paramentrs.txt");

            sw.WriteLine($"{Convert.ToInt32(without_any_act.Text)} {Convert.ToDouble(max_temperature.Text)} {Convert.ToDouble(a.Text)}");
            sw.Close();
            _ob.Set_machine_parametrs();
            Close();
        }
    }
}
