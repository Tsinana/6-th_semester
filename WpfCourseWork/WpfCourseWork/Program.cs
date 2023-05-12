using System;
using System.Collections.Generic;
using System.IO;

namespace WpfCourseWork {

    public class Program {
        static Random rnd = new Random();
        static string _lastGeneration;


        public void StartMachine() {
            start();
        }


        public string LastGeneration {
            get => _lastGeneration;
            set => _lastGeneration = value;
        }


        private static void start() {
            string file_name = CreateFolder(get_date_time(), "../../data");

            List<Box> list_box;
            Bin bin;
            (list_box, bin) = Generation_list_box();

            list_box.Sort(delegate (Box box1, Box box2) { return box2.Volume.CompareTo(box1.Volume); });

            List<Box> ans_list_box;
            int i = 0;

            (ans_list_box, i, _, _, _) = Annealing_method(bin, list_box, 100, 10000, 0.999995, file_name);

            Print_list_box(ans_list_box, bin, i, file_name);
        }

        private static string get_date_time() {
            DateTime now = DateTime.Now;
            return now.ToShortDateString().Replace('/', '-') + "_" + now.ToShortTimeString().Replace(':', '-').Replace(' ', '_');
        }

        private static string CreateFolder(string name, string path) {
            int i = -1;
            bool folderCreated = false;
            do {
                i++;
                if (!Directory.Exists($"{path}/{name}{i}")) {
                    Directory.CreateDirectory($"{path}/{name}{i}");
                    folderCreated = true;
                }
            } while (!folderCreated);
            _lastGeneration = $"{name}{i}";
            return $"{name}{i}";
        }

        private static (List<Box>, int, double, int, int) Annealing_method(Bin bin, List<Box> s0_list_box, int without_any_act, double max_temperature, double a, string file_name) {
            StreamWriter sw = new StreamWriter($"../../data/{file_name}/log_{file_name}.txt");

            List<Box> best_list_box = new List<Box>();
            best_list_box.AddRange(s0_list_box);
            List<Box> last_list_box = new List<Box>();
            last_list_box.AddRange(s0_list_box);
            double energy = Calculate_energy(Generation_sequence_box(last_list_box, bin), bin);
            double best_energy = energy;

            double min_temperature = 1;
            double temperature = max_temperature;
            int i = 0;
            int first_best_i = 0;

            double max_volume_boxes = 0;
            foreach (var item in s0_list_box) {
                max_volume_boxes += item.Volume;
            }
            double max_energy = max_volume_boxes / Convert.ToDouble(bin.Volume);
            int count_boxes = s0_list_box.Count;
            int count_a_less = 0;
            int count_without_any_act = 1;

            while (temperature > min_temperature && best_energy != 1 && max_energy != best_energy && count_without_any_act != without_any_act) {
                List<Box> new_list_box = new List<Box>(); // Snew = f(Si-1) 
                new_list_box.AddRange(last_list_box);
                Move_task(rnd, count_boxes, new_list_box, out int random_box, out byte random_condition);
                double new_energy = Calculate_energy(Generation_sequence_box(new_list_box, bin), bin);

                double delt_e = energy - new_energy; // deltE = E(Snew) - E(Si-1)

                double probability = Math.Exp(-delt_e / temperature);

                if (a <= probability) { // Переходим ли на новое состояние
                    energy = new_energy;
                    last_list_box = new_list_box;
                    count_a_less++;
                }
                if (best_energy < energy) { // Запоминаем лучшее
                    best_energy = energy;
                    best_list_box = last_list_box;
                    first_best_i = i;
                    count_without_any_act = 1;
                }

                Print_iteration(sw, i, best_energy, new_energy, random_box, random_condition); // log
                count_without_any_act++;
                i++;
                //temperature *= 0.9991;
                temperature -= 1;
                //temperature = max_temperature / (1 + i); //схема охлаждения Коши
            }
            sw.Close();
            return (best_list_box, first_best_i, best_energy, i, count_a_less);
        }

        private static void Move_task(Random rnd, int count_boxes, List<Box> new_list_box, out int random_box, out byte random_condition) {
            random_box = rnd.Next(count_boxes);
            random_condition = Convert.ToByte(rnd.Next(6));
            Box ch_box = new Box(new_list_box[random_box].Length, new_list_box[random_box].Width, new_list_box[random_box].Heigth, random_condition);
            new_list_box[random_box] = ch_box;
        }


        private static double Calculate_energy(List<((int, int, int), Box)> sequence_box, Bin bin) {
            double volume_bin = bin.Volume;
            double volume_boxes = Volume_boxes(sequence_box);
            return volume_boxes / volume_bin;
        }


        private static int Volume_boxes(List<((int, int, int), Box)> sequence_box) {
            int volume_boxes = 0;
            foreach (var coor_and_box in sequence_box)
                if (coor_and_box.Item1.Item1 != -1)
                    volume_boxes += coor_and_box.Item2.Volume;
            return volume_boxes;
        }


        private static List<((int, int, int), Box)> Generation_sequence_box(List<Box> list_box, Bin mother_bin) {
            List<((int, int, int), Box)> sequence_box = new List<((int, int, int), Box)>();

            foreach (Box box in list_box)
                sequence_box.Add(((-1, -1, -1), box));

            List<((int, int, int), Bin)> list_virtual_bin = new List<((int, int, int), Bin)>();
            ((int, int, int), Bin) empty_bin = ((0, 0, 0), mother_bin);

            do {
                if (list_virtual_bin.Count != 0) {
                    do {
                        List<((int, int, int), Bin)> list_bin_add = new List<((int, int, int), Bin)>();
                        List<((int, int, int), Bin)> list_bin_del = new List<((int, int, int), Bin)>();
                        foreach (var virtual_bin in list_virtual_bin) {
                            List<((int, int, int), Bin)> list_bin_help = Attempt_to_pack_one_box(ref sequence_box, virtual_bin);
                            if (list_bin_help != null) {
                                list_bin_del.Add(virtual_bin);
                                list_bin_add.AddRange(list_bin_help);
                            }
                        }
                        if (list_bin_del.Count != 0) {
                            foreach (var item in list_bin_del)
                                list_virtual_bin.Remove(item);
                            list_virtual_bin.AddRange(list_bin_add);
                        } else
                            break;
                    } while (true);
                }

                if (empty_bin.Item2.Volume != 0) {
                    List<((int, int, int), Bin)> list_bin_help = Attempt_to_pack_one_box(ref sequence_box, empty_bin);
                    list_virtual_bin.Clear();
                    empty_bin = ((0, 0, 0), new Bin(0, 0, 0));

                    if (list_bin_help.Count != 0)
                        foreach (var el in list_bin_help) {
                            if (el.Item1.Item2 == 0 && el.Item1.Item3 == 0) {
                                empty_bin.Item1 = el.Item1;
                                empty_bin.Item2 = el.Item2;
                            } else
                                list_virtual_bin.Add(el);
                        }
                    else
                        break;
                } else
                    break;
            } while (true);
            return sequence_box;
        }


        private static List<((int, int, int), Bin)> Attempt_to_pack_one_box(ref List<((int, int, int), Box)> sequence_box, ((int, int, int), Bin) vittual_bin) {
            List<((int, int, int), Bin)> list_vittual_bin = new List<((int, int, int), Bin)>();

            for (int i = 0; i < sequence_box.Count; i++) {
                if (sequence_box[i].Item1.Item1 == -1) {
                    ((int, int, int), Box) located_box = sequence_box[i];

                    if (located_box.Item2.Volume <= vittual_bin.Item2.Volume &&
                        located_box.Item2.Length <= vittual_bin.Item2.Length &&
                        located_box.Item2.Width <= vittual_bin.Item2.Width &&
                        located_box.Item2.Heigth <= vittual_bin.Item2.Heigth) {

                        int l = vittual_bin.Item2.Length;
                        int w = vittual_bin.Item2.Width;
                        int h = vittual_bin.Item2.Heigth;

                        int x = vittual_bin.Item1.Item1;
                        int y = vittual_bin.Item1.Item2;
                        int z = vittual_bin.Item1.Item3;

                        sequence_box[i] = (vittual_bin.Item1, located_box.Item2);

                        Bin new_vittual_bin;
                        if (l - located_box.Item2.Length != 0) {
                            new_vittual_bin = new Bin(l - located_box.Item2.Length, w, h);
                            list_vittual_bin.Add(((x + located_box.Item2.Length, y, z), new_vittual_bin));
                        }
                        if (h - located_box.Item2.Heigth != 0) {
                            new_vittual_bin = new Bin(located_box.Item2.Length, located_box.Item2.Width, h - located_box.Item2.Heigth);
                            list_vittual_bin.Add(((x, y, z + located_box.Item2.Heigth), new_vittual_bin));
                        }
                        if (w - located_box.Item2.Width != 0) {
                            new_vittual_bin = new Bin(located_box.Item2.Length, w - located_box.Item2.Width, h);
                            list_vittual_bin.Add(((x, y + located_box.Item2.Width, z), new_vittual_bin));
                        }
                        return list_vittual_bin;
                    }
                }
            }
            return list_vittual_bin;
        }


        private static void Print_list_box(List<Box> list_box, Bin bin, int i, string file_name) {
            List<((int, int, int), Box)> sequence_box = Generation_sequence_box(list_box, bin);
            StreamWriter sw = new StreamWriter($"../../data/{file_name}/output_{file_name}.txt");
            double energy = Calculate_energy(sequence_box, bin);
            sw.WriteLine("Найден на шаге: " + i + "\tЭнергетическая функция: " + energy);
            foreach (var item in sequence_box)
                sw.WriteLine(Convert.ToString(item.Item1) + "\t" + Convert.ToString(item.Item2.Size) + "\t" + item.Item2.XYZ);
            sw.Close();

            StreamWriter sw2 = new StreamWriter($"../../data/{file_name}/outputWpf_{file_name}.txt");

            foreach (var item in sequence_box)
                if (item.Item1.Item1 != -1)
                    sw2.WriteLine( (Convert.ToString(item.Item1) + "," + Convert.ToString(item.Item2.Size)).Replace("(", "").Replace(")", "").Replace(" ", ""));

            sw2.Close();
        }


        private static void Print_iteration(StreamWriter sw, int k, double Energy, double new_nergy, int random_box, byte random_con) {
            sw.WriteLine(k + "\t" + Math.Round(Energy, 4) + "\t" + Math.Round(new_nergy, 4) + "\t" + random_box + "\t" + random_con);
        }


        private static (List<Box>, Bin) Generation_list_box() {
            Bin bin = new Bin(0, 0, 0);
            List<Box> list_box = new List<Box>();
            StreamReader sr = new StreamReader("../../data/input.txt");

            string sourceFilePath = "../../data/input.txt";
            string destinationFilePath = $"../../data/{_lastGeneration}/input_{_lastGeneration}.txt";
            File.Copy(sourceFilePath, destinationFilePath);

            if (sr.Peek() != -1) {
                string line = sr.ReadLine();

                do {
                    int[] size = { 0, 0, 0 };
                    string digit = "";
                    int first_second_third = 0;
                    for (int i = 0; i < line.Length; i++) {
                        if (line[i] == ' ') {
                            size[first_second_third] = Convert.ToInt32(digit);
                            first_second_third++;
                            digit = "";
                        } else
                            digit += line[i];
                    }
                    size[first_second_third] = Convert.ToInt32(digit);

                    if (bin.Volume == 0)
                        bin = new Bin(size[0], size[1], size[2]);
                    else
                                                                                                        /*if (bin.Size.Item1 >= size[0] &&
                                                                                                            bin.Size.Item2 >= size[1] &&
                                                                                                            bin.Size.Item3 >= size[2])*/ {
                        Box box = new Box(size[0], size[1], size[2], 0);
                        list_box.Add(box);
                    }

                    line = sr.ReadLine();
                } while (line != null);

                sr.Close();

                if (list_box.Count != 0 && bin.Volume != 0)
                    return (list_box, bin);
                else
                    throw new Exception("list_box is empty or bin isn't exists");
            } else
                throw new Exception("input is empty");
        }
    }
}
