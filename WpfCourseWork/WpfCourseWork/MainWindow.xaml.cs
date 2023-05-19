using HelixToolkit.Wpf;
using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.IO;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Windows;
using System.Windows.Documents;
using System.Windows.Media;
using System.Windows.Media.Media3D;

namespace WpfCourseWork {
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window {
        static Random rnd = new Random();
        static Program _machine;
        public string MyData { get; set; }
        public MainWindow() {

            InitializeComponent();
            _machine = new Program();

            //var machine = new Program();
            //machine.StartMachine();

            //Print_scene(machine.LastGeneration);

            //Print_boxes(Read_parse_file(machine.LastGeneration));
        }

        private void Start(string file_name) {
            viewport.Children.Clear();
            viewport.Children.Add(new SunLight());
            Print_scene(file_name);
            Print_boxes(Read_parse_file(file_name));
            Set_Text(file_name);
            hide_start_menu();
        }

        public void Start(ObservableCollection<Box> list_box,Bin bin) {
            List<Box> boxList = list_box.ToList();
            Set_machine_parametrs();
            _machine.StartMachine(boxList, bin);
            Start(_machine.LastGeneration);
            hide_start_menu();
        }

        public void Set_machine_parametrs() {
            StreamReader reader = new StreamReader("machine_paramentrs.txt");
            string all_strings = reader.ReadToEnd().Replace("\n","").Replace("\r","");
            reader.Close();
            string[] arr = all_strings.Split(' ');
            _machine.Set_paraments(Convert.ToInt32(arr[0]), Convert.ToDouble(arr[1]), Convert.ToDouble(arr[2]));
        }

        public void Set_Text(string file_name) {
            StreamReader sr_r = new StreamReader($"C:\\Users\\Tsinana\\GitHub\\6-th_semester\\WpfCourseWork\\WpfCourseWork\\data\\{file_name}\\output_{file_name}.txt");
            StreamReader sr_l = new StreamReader($"C:\\Users\\Tsinana\\GitHub\\6-th_semester\\WpfCourseWork\\WpfCourseWork\\data\\{file_name}\\log_{file_name}.txt");

            tb_r.Text = sr_r.ReadToEnd();
            tb_l.Text = sr_l.ReadToEnd();

            sr_r.Close();
            sr_l.Close();
        }

        private void hide_start_menu() { 
            l_shift.Visibility = Visibility.Collapsed;
            l_start.Visibility = Visibility.Collapsed;
            b_new.Visibility = Visibility.Collapsed;
            b_open.Visibility = Visibility.Collapsed;
            gridMain.Visibility = Visibility.Visible;
            viewport.Visibility = Visibility.Visible;
        }

        private void Print_scene(string file_name) {
            int[] size_container = Get_size_of_container(file_name);
            Print_container(size_container[0], size_container[1], size_container[2]);
            Print_oXYZ(size_container[0], size_container[1], size_container[2]);
            viewport.Camera.Position = new Point3D((Convert.ToDouble(size_container[0])/2) + 2, (Convert.ToDouble(size_container[1])/2) + 16, (Convert.ToDouble(size_container[2])/2) + 20);
        }

        private static int[] Get_size_of_container(string file_name) {
            StreamReader reader = new StreamReader($"C:\\Users\\Tsinana\\GitHub\\6-th_semester\\WpfCourseWork\\WpfCourseWork\\data\\{file_name}\\input_{file_name}.txt");
            string all_strings = reader.ReadLine().Replace("\n","").Replace("\r","");
            reader.Close();
            return Array.ConvertAll(all_strings.Split(' '), int.Parse);
        }

        private static string[] Read_parse_file(string file_name) {
            StreamReader reader = new StreamReader($"C:\\Users\\Tsinana\\GitHub\\6-th_semester\\WpfCourseWork\\WpfCourseWork\\data\\{file_name}\\outputWpf_{file_name}.txt");
            string all_strings = reader.ReadToEnd().Replace("\n",",").Replace("\r","");
            all_strings = all_strings.Remove(all_strings.Length - 1, 1);
            reader.Close();
            return all_strings.Split(',');
        }


        private void Print_boxes(string[] parse_string) {
            for (int i = 0; i < parse_string.Length; i += 6) {
                int x = Convert.ToInt32(parse_string[i]);
                int y = Convert.ToInt32(parse_string[i+1]);
                int z = Convert.ToInt32(parse_string[i+2]);
                int length = Convert.ToInt32(parse_string[i+3]);
                int width = Convert.ToInt32(parse_string[i+4]);
                int height = Convert.ToInt32(parse_string[i+5]);

                var box = Create_box_diff(length, width, height, Get_box_material(Random_color()));
                box.Transform = new TranslateTransform3D(x, y, z);
                viewport.Children.Add(box);
            }
        }
        private Color Random_color() {
            byte red = Convert.ToByte(rnd.Next(128, 256));
            byte green = Convert.ToByte(rnd.Next(128, 256));
            byte blue = Convert.ToByte(rnd.Next(128, 256));
            return Color.FromArgb(255, red, green, blue);
        }


        private System.Windows.Media.Media3D.DiffuseMaterial Get_box_material(Color color) {
            return new System.Windows.Media.Media3D.DiffuseMaterial(new SolidColorBrush(color));
        }


        private SpecularMaterial Get_container_material() {
            return new SpecularMaterial(new SolidColorBrush(Color.FromArgb(255, 255, 255, 255)), 1000);
        }


        private void Print_container(double x, double y, double z) {
            var container = Create_box_spec(x, y, z, Get_container_material());
            viewport.Children.Add(container);
        }


        private void Print_oXYZ(double x, double y, double z) {
            Print_labels(Convert.ToInt32(x), 'x');
            Print_labels(Convert.ToInt32(y), 'y');
            Print_labels(Convert.ToInt32(z), 'z');
        }


        private void Print_labels(int value, char x_y_z) {
            var cur_value = value;
            int step;
            if (value < 10) {
                value = 10;
                step = 1;
            } else if (value <= 50) {
                value = (value / 10) * 10 + 10;
                step = 5;
            } else if (value <= 200) {
                value = (value / 10) * 10 + 10;
                step = 10;
            } else {
                value = (value / 100) * 100 + 100;
                step = 100;
            }

            LinesVisual3D axis;

            switch (x_y_z) {
                case 'x':
                    for (int i = 0; i <= value; i += step) {
                        var label = Create_label(i, -3, 0, i.ToString(), Brushes.Black);
                        viewport.Children.Add(label);
                    }
                    var cur_label = Create_label(cur_value, -3, 0, cur_value.ToString(), Brushes.Red);
                    viewport.Children.Add(cur_label);

                    axis = Create_line(0, 0, 0, value, 0, 0, Colors.Red);
                    break;

                case 'y':
                    for (int i = 0; i <= value; i += step) {
                        var label = Create_label(-3, i, 0, i.ToString(), Brushes.Black);
                        viewport.Children.Add(label);
                    }
                    cur_label = Create_label(-3, cur_value, 0, cur_value.ToString(), Brushes.Red);
                    viewport.Children.Add(cur_label);

                    axis = Create_line(0, 0, 0, 0, value, 0, Colors.Green);
                    break;

                case 'z':
                    for (int i = 0; i <= value; i += step) {
                        var label = Create_label(0, -3, i, i.ToString(), Brushes.Black);
                        viewport.Children.Add(label);
                    }
                    cur_label = Create_label(0, -3, cur_value, cur_value.ToString(), Brushes.Red);
                    viewport.Children.Add(cur_label);

                    axis = Create_line(0, 0, 0, 0, 0, value, Colors.Blue);
                    break;

                default:
                    throw new ArgumentException($"Invalid char: {x_y_z}");
            }
            viewport.Children.Add(axis);
        }


        private BillboardTextVisual3D Create_label(double x, double y, double z, string text, Brush foreground) {
            return new BillboardTextVisual3D {
                Position = new Point3D(x, y, z),
                Text = text,
                Foreground = foreground
            };
        }


        private static LinesVisual3D Create_line(double x1, double y1, double z1, double x2, double y2, double z2, Color color) {
            return new LinesVisual3D {
                Points = new Point3DCollection {
                    new Point3D(x1, y1, z1),
                    new Point3D(x2, y2, z2)
                },
                Thickness = 2,
                Color = color
            };
        }


        private BoxVisual3D Create_box_spec(double length, double width, double height, SpecularMaterial material) {
            return new BoxVisual3D {
                Length = length,
                Width = width,
                Height = height,
                Center = new Point3D(length / 2, width / 2, height / 2),
                Material = material
            };
        }


        private BoxVisual3D Create_box_diff(double length, double width, double height, System.Windows.Media.Media3D.DiffuseMaterial material) {
            return new BoxVisual3D {
                Length = length,
                Width = width,
                Height = height,
                Center = new Point3D(length / 2, width / 2, height / 2),
                Material = material
            };
        }
        //
        // Прослушка кнопок
        //
        private void MenuNew_Click(object sender, RoutedEventArgs e) {
            WpfCourseWork.NewTaskDialog dialog = new WpfCourseWork.NewTaskDialog(this);
            dialog.ShowDialog();
        }

        //Получает название директории             Close();MenuExit_Click Set_parameters_Click
        private void MenuOpen_Click(object sender, RoutedEventArgs e) {
            string path;
            OpenFileDialog openFileDialog = new OpenFileDialog();
            if (openFileDialog.ShowDialog() == true) {
                path = openFileDialog.FileName;
                string[] arr = path.Split('\\');
                Start(arr[arr.Length - 2]);
            }
        }

        private void MenuExit_Click(object sender, RoutedEventArgs e) {
            Close();
        }

        private void SetParameters_Click(object sender, RoutedEventArgs e) {
            WpfCourseWork.ProjectSetup dialog = new WpfCourseWork.ProjectSetup(this);
            dialog.ShowDialog();
        }
    }
}
