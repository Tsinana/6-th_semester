using System;

namespace WpfCourseWork {

    public struct Bin {
        private int _length;
        private int _width;
        private int _heigth;
        private int _volume;

        public Bin(int length, int width, int heigth) {
            _length = length;
            _width = width;
            _heigth = heigth;
            _volume = width * heigth * length;
        }

        public (int, int, int) Size => (_length, _width, _heigth);
        public int Length => _length;
        public int Width => _width;
        public int Heigth => _heigth;
        public int Volume => _volume;
    }

    public struct Box {
        private int _length;
        private int _width;
        private int _heigth;
        private int _volume;
        private byte _condition;
        private string _xyz_condition;
        /*		private (int, int) _leftmost_point;*/

        /*public Box() : this(0, 0, 0, 0) { }*/

        public Box(int length, int width, int heigth, byte condition/*, (int, int) leftmost_point*/) {
            _length = length;
            _width = width;
            _heigth = heigth;
            _condition = condition;
            _xyz_condition = "";
            _volume = width * heigth * length;
            Condition();
            /*			_leftmost_point = leftmost_point;*/
        }


        private void Condition() {
            (int, int, int) newSize;

            switch (_condition) {
                case 0:
                    newSize = (_length, _width, _heigth);// XYZ
                    _xyz_condition = "XYZ";
                    break;
                case 1:
                    newSize = (_length, _heigth, _width);// XZY
                    _xyz_condition = "XZY";
                    break;
                case 2:
                    newSize = (_width, _length, _heigth);// YXZ
                    _xyz_condition = "YXZ";
                    break;
                case 3:
                    newSize = (_width, _heigth, _length);// YZX
                    _xyz_condition = "YZX";
                    break;
                case 4:
                    newSize = (_heigth, _length, _width);// ZXY
                    _xyz_condition = "ZXY";
                    break;
                case 5:
                    newSize = (_heigth, _width, _length);// ZYX
                    _xyz_condition = "ZYX";
                    break;
                default:
                    throw new Exception("Condition != 0..5");
            }

            _length = newSize.Item1;
            _width = newSize.Item2;
            _heigth = newSize.Item3;
        }

        public (int, int, int) Size => (_length, _width, _heigth);
        public int Length => _length;
        public int Width => _width;
        public int Heigth => _heigth;
        public int Volume => _volume;
        public string XYZ => _xyz_condition;
    }
}
