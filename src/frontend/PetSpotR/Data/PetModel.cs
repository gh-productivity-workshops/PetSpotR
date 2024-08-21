using Dapr.Client;

namespace PetSpotR.Models 
{
    public class PetModel
    {
        public string Name { get; set; }
        public string Type { get; set; }
        public string Breed { get; set; }
        public string City { get; set; }
        public string OwnerName { get; set; }
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
            City = "";
            OwnerName = "";
            OwnerEmail = "";
            ID = Guid.NewGuid().ToString();
            State = "new";
            Images = new();

        }

        public async Task SavePetStateAsync(DaprClient daprClient, string storeName)
        {
            try {
                await daprClient.SaveStateAsync(
                    storeName: storeName,
                    key: ID,
                    value: this
                );
            } catch {
                throw;
            }

            return;
        }

        public async Task PublishLostPetAsync(DaprClient daprClient, string pubsubName)
        {
            try {
                await daprClient.PublishEventAsync(
                    pubsubName: pubsubName,
                    topicName: "lostPet",
                    data: new Dictionary<string, string>
                    {
                        { "petId", ID }
                    }
                );
            } catch {
                throw;
            }

            return;
        }
    }
}
