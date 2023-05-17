using Dapr.Client;

namespace PetSpotR.Models 
{
    public class PetModel
    {
        public string Name { get; set; }
        public string Type { get; set; }
        public string Breed { get; set; }
        public string OwnerEmail { get; set; }
        public string ID { get; set; }
        public string State { get; set; }
        public List<string> Images { get; set; }

        // Constructor
        public PetModel()
        {
            Name = "";
            Type = "";
            Breed = "";
            OwnerEmail = "";
            ID = Guid.NewGuid().ToString();
            State = "new";
            Images = new();
        }

        // THis is where you'll add the methods to save the pet state and publish the lost pet

        public async Task SavePetStateAsync(DaprClient daprClient)
        {
            Console.WriteLine("Not implemented");
            
            return;
        }

        public async Task PublishLostPetAsync(DaprClient daprClient)
        {
            Console.WriteLine("Not implemented");

            return;
        }
    }
}
