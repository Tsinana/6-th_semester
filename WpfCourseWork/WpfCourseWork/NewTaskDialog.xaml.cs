using Microsoft.Win32;
using System;
using System.Collections.ObjectModel;
using System.IO;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace WpfCourseWork {
    public partial class NewTaskDialog : Window {
        private ObservableCollection<Box> boxes = new ObservableCollection<Box>();
        private static MainWindow _ob;


        public NewTaskDialog(MainWindow ob) {
            InitializeComponent();
            _ob = ob;
            boxGrid.ItemsSource = boxes;
        }


        private void Clear_Click(object sender, RoutedEventArgs e) {
            length_box.Text = string.Empty;
            width_box.Text = string.Empty;
            height_box.Text = string.Empty;
        }


        private void Add_Click(object sender, RoutedEventArgs e) {
            boxes.Add(new Box(Convert.ToInt32(length_box.Text), Convert.ToInt32(width_box.Text), Convert.ToInt32(height_box.Text), 0));
        }


        private void DataGrid_MouseDown(object sender, MouseButtonEventArgs e) {
            {
                if (e.RightButton == MouseButtonState.Pressed) {
                    var dataGrid = (DataGrid)sender;
                    foreach (var selectedBox in dataGrid.SelectedItems.OfType<Box>().ToList()) {
                        boxes.Remove(selectedBox);
                    }
                }
            }
        }


        private void Import_Click(object sender, RoutedEventArgs e) {
            OpenFileDialog openFileDialog = new OpenFileDialog();
            if (openFileDialog.ShowDialog() == true)
                Pull_text(Get_input(openFileDialog));
        }


        private void Pull_text(int[] parse_input) {
            length_container.Text = Convert.ToString(parse_input[0]);
            width_container.Text = Convert.ToString(parse_input[1]);
            height_container.Text = Convert.ToString(parse_input[2]);
            for (int i = 3; i < parse_input.Length; i += 3) {
                boxes.Add(new Box(parse_input[i], parse_input[i + 1], parse_input[i + 2], 0));
            }
        }


        private int[] Get_input(OpenFileDialog openFileDialog) {
            StreamReader reader = new StreamReader(openFileDialog.FileName);
            string all_strings = reader.ReadToEnd().Replace("\n"," ").Replace("\r","").Trim();
            reader.Close();
            return Array.ConvertAll(all_strings.Split(' '), int.Parse);
        }


        private void Esc_Click(object sender, RoutedEventArgs e) {
            Close();
        }


        private void Ok_Click(object sender, RoutedEventArgs e) {
            Bin bin = new Bin(Convert.ToInt32(length_container.Text),Convert.ToInt32(width_container.Text),Convert.ToInt32(height_container.Text));
            _ob.Start(boxes, bin);
            Close();
        }
    }
}
