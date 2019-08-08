namespace Garage.Data.Entities.Cars
{
    public class VehicleModification
    {
        public int VehicleModificationID { get; set; }
        public int VehicleModelID { get; set; }
        public string TypeName { get; set; }
        public string TypeRange { get; set; }
        public string Engines { get; set; }
        public string KW { get; set; }
        public string HP { get; set; }
        public int ccmTech { get; set; }
        public float Capacity { get; set; }
        public int Cylinders { get; set; }
        public int Valve { get; set; }
        public string Fuel { get; set; }
        public string EngineType { get; set; }
        public string FuelPreparation { get; set; }
        public string BodyType { get; set; }
        public string EngineTypDriveTypee { get; set; }
        public string Tonnage { get; set; }
       
    }
}