pragma solidity >=0.4.21 <0.6.0;

contract carboncredit {
    uint32 public certificate_id = 0;   // certificate ID
    uint32 public participant_id = 0;   // Participant ID
    uint32 public owner_id = 0;   // Ownership ID

    struct certificate {
        string certificateNumber;
        string serialNumber;
        address certificateOwner;
        uint32 carboncreditnumber;
        uint32 mfgTimeStamp;
    }

    mapping(uint32 => certificate) public certificates;

    struct participant {
        string userName;
        string password;
        string participantType;
        address participantAddress;
    }
    mapping(uint32 => participant) public participants;

    struct ownership {
        uint32 certificateId;
        uint32 ownerId;
        uint32 trxTimeStamp;
        address certificateOwner;
    }
    mapping(uint32 => ownership) public ownerships; // ownerships by ownership ID (owner_id)
    mapping(uint32 => uint32[]) public certificateTrack;  // ownerships by certificate ID (certificate_id) / Movement track for a certificate

    event TransferOwnership(uint32 certificateId);

    function addParticipant(string memory _name, string memory _pass, address _pAdd, string memory _pType) public returns (uint32){
        uint32 userId = participant_id++;
        participants[userId].userName = _name;
        participants[userId].password = _pass;
        participants[userId].participantAddress = _pAdd;
        participants[userId].participantType = _pType;

        return userId;
    }

    function getParticipant(uint32 _participant_id) public view returns (string memory,address,string memory) {
        return (participants[_participant_id].userName,
                participants[_participant_id].participantAddress,
                participants[_participant_id].participantType);
    }

    function addcertificate(uint32 _ownerId,
                        string memory _certificateNumber,
                        
                        string memory _serialNumber,
                        uint32 _certificatecarboncreditnumber) public returns (uint32) {
        if(keccak256(abi.encodePacked(participants[_ownerId].participantType)) == keccak256("vetting")) {
            uint32 certificateId = certificate_id++;

            certificates[certificateId].certificateNumber = _certificateNumber;
    
            certificates[certificateId].serialNumber = _serialNumber;
            certificates[certificateId].carboncreditnumber = _certificatecarboncreditnumber;
            certificates[certificateId].certificateOwner = participants[_ownerId].participantAddress;
            certificates[certificateId].mfgTimeStamp = uint32(now);

            return certificateId;
        }

       return 0;
    }

    modifier onlyOwner(uint32 _certificateId) {
         require(msg.sender == certificates[_certificateId].certificateOwner,"");
         _;

    }

    function getcertificate(uint32 _certificateId) public view returns (string memory,string memory,uint32,address,uint32){
        return (certificates[_certificateId].certificateNumber,
                
                certificates[_certificateId].serialNumber,
                certificates[_certificateId].carboncreditnumber,
                certificates[_certificateId].certificateOwner,
                certificates[_certificateId].mfgTimeStamp);
    }

    function newOwner(uint32 _user1Id,uint32 _user2Id, uint32 _prodId) onlyOwner(_prodId) public returns (bool) {
        participant memory p1 = participants[_user1Id];
        participant memory p2 = participants[_user2Id];
        uint32 ownership_id = owner_id++;

        if(keccak256(abi.encodePacked(p1.participantType)) == keccak256("vetting")
            && keccak256(abi.encodePacked(p2.participantType))==keccak256("issuer")){
            ownerships[ownership_id].certificateId = _prodId;
            ownerships[ownership_id].certificateOwner = p2.participantAddress;
            ownerships[ownership_id].ownerId = _user2Id;
            ownerships[ownership_id].trxTimeStamp = uint32(now);
            certificates[_prodId].certificateOwner = p2.participantAddress;
            certificateTrack[_prodId].push(ownership_id);
            emit TransferOwnership(_prodId);

            return (true);
        }
        else if(keccak256(abi.encodePacked(p1.participantType)) == keccak256("issuer") && keccak256(abi.encodePacked(p2.participantType))==keccak256("issuer")){
            ownerships[ownership_id].certificateId = _prodId;
            ownerships[ownership_id].certificateOwner = p2.participantAddress;
            ownerships[ownership_id].ownerId = _user2Id;
            ownerships[ownership_id].trxTimeStamp = uint32(now);
            certificates[_prodId].certificateOwner = p2.participantAddress;
            certificateTrack[_prodId].push(ownership_id);
            emit TransferOwnership(_prodId);

            return (true);
        }
        else if(keccak256(abi.encodePacked(p1.participantType)) == keccak256("issuer") && keccak256(abi.encodePacked(p2.participantType))==keccak256("subsidary")){
            ownerships[ownership_id].certificateId = _prodId;
            ownerships[ownership_id].certificateOwner = p2.participantAddress;
            ownerships[ownership_id].ownerId = _user2Id;
            ownerships[ownership_id].trxTimeStamp = uint32(now);
            certificates[_prodId].certificateOwner = p2.participantAddress;
            certificateTrack[_prodId].push(ownership_id);
            emit TransferOwnership(_prodId);

            return (true);
        }

        return (false);
    }

   function getProvenance(uint32 _prodId) external view returns (uint32[] memory) {

       return certificateTrack[_prodId];
    }

    function getOwnership(uint32 _regId)  public view returns (uint32,uint32,address,uint32) {

        ownership memory r = ownerships[_regId];

         return (r.certificateId,r.ownerId,r.certificateOwner,r.trxTimeStamp);
    }

    function authenticateParticipant(uint32 _uid,
                                    string memory _uname,
                                    string memory _pass,
                                    string memory _utype) public view returns (bool){
        if(keccak256(abi.encodePacked(participants[_uid].participantType)) == keccak256(abi.encodePacked(_utype))) {
            if(keccak256(abi.encodePacked(participants[_uid].userName)) == keccak256(abi.encodePacked(_uname))) {
                if(keccak256(abi.encodePacked(participants[_uid].password)) == keccak256(abi.encodePacked(_pass))) {
                    return (true);
                }
            }
        }

        return (false);
    }
}