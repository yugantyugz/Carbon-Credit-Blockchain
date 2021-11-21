var CarbonCredit = artifacts.require('./CarbonCredit.sol');

contract('CarbonCredit', async accounts => {
  it("should create a Participant", async () => {
    let instance = await CarbonCredit.deployed();
    let participantId = await instance.addParticipant("A","passA","0x8858d98eC700363a2A1D9308c7312653d186f9B0","vetting");
    let participant = await instance.participants(0);
    assert.equal(participant[0], "A");
    assert.equal(participant[2], "vetting");

    participantId = await instance.addParticipant("B","passB","0xd295d0BF5Fb583219CB7b8AB1a3F3f5E218D0442","issuer");
    participant = await instance.participants(1);
    assert.equal(participant[0], "B");
    assert.equal(participant[2], "issuer");

    participantId = await instance.addParticipant("C","passC","0x9c4c246bca58D3b821bFFdbdB88D60E8E2727E84","subsidary");
    participant = await instance.participants(2);
    assert.equal(participant[0], "C");
    assert.equal(participant[2], "subsidary");
  });

  it("should return Participant details", async () => {
    let instance = await CarbonCredit.deployed();
    let participantDetails = await instance.getParticipant(0);
    assert.equal(participantDetails[0], "A");

    instance = await CarbonCredit.deployed();
    participantDetails = await instance.getParticipant(1);
    assert.equal(participantDetails[0], "B");

    instance = await CarbonCredit.deployed();
    participantDetails = await instance.getParticipant(2);
    assert.equal(participantDetails[0], "C");
  })
});
