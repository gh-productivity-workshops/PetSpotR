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

        public async Task SavePetStateAsync(DaprClient daprClient)
        {
            // Delete this line and replace it with a comment describing what you want to do
            Console.WriteLine("Not implemented");
        }

        public async Task PublishLostPetAsync(DaprClient daprClient)
        {
            // Delete this line and replace it with a comment describing what you want to do
            Console.WriteLine("Not implemented");
        }
    }
}
