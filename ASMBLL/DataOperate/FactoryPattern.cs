using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Services.Description;
//using System.Web.Services.Description;
using Microsoft.Extensions.DependencyInjection;
namespace ASMBLL.DataOperate
{
    class FactoryPattern
    {
    }

    public interface IShape
    {
          void GetInputValues();
          void DisplaySurfaceArea();
          void DisplayVolume();
    }
    public class Cube : IShape
    {
        public decimal Side { get; set; }

        public void GetInputValues()
        {
            Console.WriteLine("Side : ");
            Side = decimal.Parse(Console.ReadLine());
        }

        public void DisplaySurfaceArea()
        {
            Console.WriteLine("Surface Area of the Cube is :" + (6 * Side * Side));
        }

        public void DisplayVolume()
        {
            Console.WriteLine("Volume of the Cube is :" + (Side * Side * Side));
        }
    }
    public class Sphere : IShape
    {
        public decimal Radius { get; set; }

        public void GetInputValues()
        {
            Console.WriteLine("Radius : ");
            Radius = decimal.Parse(Console.ReadLine());
        }

        public void DisplaySurfaceArea()
        {
            Console.WriteLine("Surface Area of the sphere is :" + (4 * 3.14m * Radius * Radius));
        }

        public void DisplayVolume()
        {
            Console.WriteLine("Volume of the sphere is :" + (4 / 3 * 3.14m * Radius * Radius * Radius));
        }
    }
    public enum ShapeEnum
    {
        Sphere,
        Cube
    }

    public class ShapeFactory : IShapeFactory
    {
        private readonly IServiceProvider _serviceProvider;

        public ShapeFactory(IServiceProvider serviceProvider)
        {
            _serviceProvider = serviceProvider;
        }

        public IShape GetShape(ShapeEnum shapeEnum)
        {
            switch (shapeEnum)
            {
                case ShapeEnum.Cube:
                    return (IShape)_serviceProvider.GetService(typeof(Cube));
                case ShapeEnum.Sphere:
                    return (IShape)_serviceProvider.GetService(typeof(Sphere));
                default:
                    throw new ArgumentOutOfRangeException(nameof(shapeEnum), shapeEnum, $"Shape of {shapeEnum} is not supported.");
            }
        }
    }

    public interface IShapeFactory
    {
          IShape GetShape(ShapeEnum shapeEnum);
    }

    class Program
    {
        static void Main(string[] args)
        {
            //setup our DI
            //var serviceProvider = new ServiceCollection()
            //    .AddTransient<IShapeFactory, ShapeFactory>()
            //    .AddTransient<IShapeCalculationService, ShapeCalculationService>()
            //    .AddScoped<Sphere>()
            //    .AddScoped<IShape, Sphere>(s => s.GetService<Sphere>())
            //    .AddScoped<Cube>()
            //    .AddScoped<IShape, Cube>(s => s.GetService<Cube>())
            //    .BuildServiceProvider();

            ////do the actual work here
            //var service = serviceProvider.GetService<IShapeCalculationService>();
            //service.CalculateShapeMeasurements();
        }
 
    }
    public class ShapeCalculationService : IShapeCalculationService
    {
        private readonly IShapeFactory _shapeFactory;
        private IShape _shape;

        public ShapeCalculationService(IShapeFactory shapeFactory)
        {
            _shapeFactory = shapeFactory;
        }

        public void CalculateShapeMeasurements()
        {
            _shape = GetShapeFromUser();
            _shape.GetInputValues();
            _shape.DisplaySurfaceArea();
            _shape.DisplayVolume();
        }

        private IShape GetShapeFromUser()
        {
            Console.WriteLine("Enter the serial no. for the shape you want to choose :");
            Console.WriteLine("1. Cube");
            Console.WriteLine("2. Sphere");
            var serialNumber = int.Parse(Console.ReadLine());

            switch (serialNumber)
            {
                case 1:
                    return _shapeFactory.GetShape(ShapeEnum.Cube);
                case 2:
                    return _shapeFactory.GetShape(ShapeEnum.Sphere);
                default:
                    throw new ArgumentOutOfRangeException("Invalid input.");
            }
        }
    }

    public interface IShapeCalculationService
    {
          void CalculateShapeMeasurements();
    }
}
