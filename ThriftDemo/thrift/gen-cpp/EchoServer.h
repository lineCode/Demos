/**
 * Autogenerated by Thrift Compiler (0.9.1)
 *
 * DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
 *  @generated
 */
#ifndef EchoServer_H
#define EchoServer_H

#include <thrift/TDispatchProcessor.h>
#include "EchoServer_types.h"



class EchoServerIf {
 public:
  virtual ~EchoServerIf() {}
  virtual void Echo(std::string& _return, const std::string& msg) = 0;
  virtual void SendPacket(Packet& _return, const Packet& p) = 0;
};

class EchoServerIfFactory {
 public:
  typedef EchoServerIf Handler;

  virtual ~EchoServerIfFactory() {}

  virtual EchoServerIf* getHandler(const ::apache::thrift::TConnectionInfo& connInfo) = 0;
  virtual void releaseHandler(EchoServerIf* /* handler */) = 0;
};

class EchoServerIfSingletonFactory : virtual public EchoServerIfFactory {
 public:
  EchoServerIfSingletonFactory(const boost::shared_ptr<EchoServerIf>& iface) : iface_(iface) {}
  virtual ~EchoServerIfSingletonFactory() {}

  virtual EchoServerIf* getHandler(const ::apache::thrift::TConnectionInfo&) {
    return iface_.get();
  }
  virtual void releaseHandler(EchoServerIf* /* handler */) {}

 protected:
  boost::shared_ptr<EchoServerIf> iface_;
};

class EchoServerNull : virtual public EchoServerIf {
 public:
  virtual ~EchoServerNull() {}
  void Echo(std::string& /* _return */, const std::string& /* msg */) {
    return;
  }
  void SendPacket(Packet& /* _return */, const Packet& /* p */) {
    return;
  }
};

typedef struct _EchoServer_Echo_args__isset {
  _EchoServer_Echo_args__isset() : msg(false) {}
  bool msg;
} _EchoServer_Echo_args__isset;

class EchoServer_Echo_args {
 public:

  EchoServer_Echo_args() : msg() {
  }

  virtual ~EchoServer_Echo_args() throw() {}

  std::string msg;

  _EchoServer_Echo_args__isset __isset;

  void __set_msg(const std::string& val) {
    msg = val;
  }

  bool operator == (const EchoServer_Echo_args & rhs) const
  {
    if (!(msg == rhs.msg))
      return false;
    return true;
  }
  bool operator != (const EchoServer_Echo_args &rhs) const {
    return !(*this == rhs);
  }

  bool operator < (const EchoServer_Echo_args & ) const;

  uint32_t read(::apache::thrift::protocol::TProtocol* iprot);
  uint32_t write(::apache::thrift::protocol::TProtocol* oprot) const;

};


class EchoServer_Echo_pargs {
 public:


  virtual ~EchoServer_Echo_pargs() throw() {}

  const std::string* msg;

  uint32_t write(::apache::thrift::protocol::TProtocol* oprot) const;

};

typedef struct _EchoServer_Echo_result__isset {
  _EchoServer_Echo_result__isset() : success(false) {}
  bool success;
} _EchoServer_Echo_result__isset;

class EchoServer_Echo_result {
 public:

  EchoServer_Echo_result() : success() {
  }

  virtual ~EchoServer_Echo_result() throw() {}

  std::string success;

  _EchoServer_Echo_result__isset __isset;

  void __set_success(const std::string& val) {
    success = val;
  }

  bool operator == (const EchoServer_Echo_result & rhs) const
  {
    if (!(success == rhs.success))
      return false;
    return true;
  }
  bool operator != (const EchoServer_Echo_result &rhs) const {
    return !(*this == rhs);
  }

  bool operator < (const EchoServer_Echo_result & ) const;

  uint32_t read(::apache::thrift::protocol::TProtocol* iprot);
  uint32_t write(::apache::thrift::protocol::TProtocol* oprot) const;

};

typedef struct _EchoServer_Echo_presult__isset {
  _EchoServer_Echo_presult__isset() : success(false) {}
  bool success;
} _EchoServer_Echo_presult__isset;

class EchoServer_Echo_presult {
 public:


  virtual ~EchoServer_Echo_presult() throw() {}

  std::string* success;

  _EchoServer_Echo_presult__isset __isset;

  uint32_t read(::apache::thrift::protocol::TProtocol* iprot);

};

typedef struct _EchoServer_SendPacket_args__isset {
  _EchoServer_SendPacket_args__isset() : p(false) {}
  bool p;
} _EchoServer_SendPacket_args__isset;

class EchoServer_SendPacket_args {
 public:

  EchoServer_SendPacket_args() {
  }

  virtual ~EchoServer_SendPacket_args() throw() {}

  Packet p;

  _EchoServer_SendPacket_args__isset __isset;

  void __set_p(const Packet& val) {
    p = val;
  }

  bool operator == (const EchoServer_SendPacket_args & rhs) const
  {
    if (!(p == rhs.p))
      return false;
    return true;
  }
  bool operator != (const EchoServer_SendPacket_args &rhs) const {
    return !(*this == rhs);
  }

  bool operator < (const EchoServer_SendPacket_args & ) const;

  uint32_t read(::apache::thrift::protocol::TProtocol* iprot);
  uint32_t write(::apache::thrift::protocol::TProtocol* oprot) const;

};


class EchoServer_SendPacket_pargs {
 public:


  virtual ~EchoServer_SendPacket_pargs() throw() {}

  const Packet* p;

  uint32_t write(::apache::thrift::protocol::TProtocol* oprot) const;

};

typedef struct _EchoServer_SendPacket_result__isset {
  _EchoServer_SendPacket_result__isset() : success(false) {}
  bool success;
} _EchoServer_SendPacket_result__isset;

class EchoServer_SendPacket_result {
 public:

  EchoServer_SendPacket_result() {
  }

  virtual ~EchoServer_SendPacket_result() throw() {}

  Packet success;

  _EchoServer_SendPacket_result__isset __isset;

  void __set_success(const Packet& val) {
    success = val;
  }

  bool operator == (const EchoServer_SendPacket_result & rhs) const
  {
    if (!(success == rhs.success))
      return false;
    return true;
  }
  bool operator != (const EchoServer_SendPacket_result &rhs) const {
    return !(*this == rhs);
  }

  bool operator < (const EchoServer_SendPacket_result & ) const;

  uint32_t read(::apache::thrift::protocol::TProtocol* iprot);
  uint32_t write(::apache::thrift::protocol::TProtocol* oprot) const;

};

typedef struct _EchoServer_SendPacket_presult__isset {
  _EchoServer_SendPacket_presult__isset() : success(false) {}
  bool success;
} _EchoServer_SendPacket_presult__isset;

class EchoServer_SendPacket_presult {
 public:


  virtual ~EchoServer_SendPacket_presult() throw() {}

  Packet* success;

  _EchoServer_SendPacket_presult__isset __isset;

  uint32_t read(::apache::thrift::protocol::TProtocol* iprot);

};

class EchoServerClient : virtual public EchoServerIf {
 public:
  EchoServerClient(boost::shared_ptr< ::apache::thrift::protocol::TProtocol> prot) :
    piprot_(prot),
    poprot_(prot) {
    iprot_ = prot.get();
    oprot_ = prot.get();
  }
  EchoServerClient(boost::shared_ptr< ::apache::thrift::protocol::TProtocol> iprot, boost::shared_ptr< ::apache::thrift::protocol::TProtocol> oprot) :
    piprot_(iprot),
    poprot_(oprot) {
    iprot_ = iprot.get();
    oprot_ = oprot.get();
  }
  boost::shared_ptr< ::apache::thrift::protocol::TProtocol> getInputProtocol() {
    return piprot_;
  }
  boost::shared_ptr< ::apache::thrift::protocol::TProtocol> getOutputProtocol() {
    return poprot_;
  }
  void Echo(std::string& _return, const std::string& msg);
  void send_Echo(const std::string& msg);
  void recv_Echo(std::string& _return);
  void SendPacket(Packet& _return, const Packet& p);
  void send_SendPacket(const Packet& p);
  void recv_SendPacket(Packet& _return);
 protected:
  boost::shared_ptr< ::apache::thrift::protocol::TProtocol> piprot_;
  boost::shared_ptr< ::apache::thrift::protocol::TProtocol> poprot_;
  ::apache::thrift::protocol::TProtocol* iprot_;
  ::apache::thrift::protocol::TProtocol* oprot_;
};

class EchoServerProcessor : public ::apache::thrift::TDispatchProcessor {
 protected:
  boost::shared_ptr<EchoServerIf> iface_;
  virtual bool dispatchCall(::apache::thrift::protocol::TProtocol* iprot, ::apache::thrift::protocol::TProtocol* oprot, const std::string& fname, int32_t seqid, void* callContext);
 private:
  typedef  void (EchoServerProcessor::*ProcessFunction)(int32_t, ::apache::thrift::protocol::TProtocol*, ::apache::thrift::protocol::TProtocol*, void*);
  typedef std::map<std::string, ProcessFunction> ProcessMap;
  ProcessMap processMap_;
  void process_Echo(int32_t seqid, ::apache::thrift::protocol::TProtocol* iprot, ::apache::thrift::protocol::TProtocol* oprot, void* callContext);
  void process_SendPacket(int32_t seqid, ::apache::thrift::protocol::TProtocol* iprot, ::apache::thrift::protocol::TProtocol* oprot, void* callContext);
 public:
  EchoServerProcessor(boost::shared_ptr<EchoServerIf> iface) :
    iface_(iface) {
    processMap_["Echo"] = &EchoServerProcessor::process_Echo;
    processMap_["SendPacket"] = &EchoServerProcessor::process_SendPacket;
  }

  virtual ~EchoServerProcessor() {}
};

class EchoServerProcessorFactory : public ::apache::thrift::TProcessorFactory {
 public:
  EchoServerProcessorFactory(const ::boost::shared_ptr< EchoServerIfFactory >& handlerFactory) :
      handlerFactory_(handlerFactory) {}

  ::boost::shared_ptr< ::apache::thrift::TProcessor > getProcessor(const ::apache::thrift::TConnectionInfo& connInfo);

 protected:
  ::boost::shared_ptr< EchoServerIfFactory > handlerFactory_;
};

class EchoServerMultiface : virtual public EchoServerIf {
 public:
  EchoServerMultiface(std::vector<boost::shared_ptr<EchoServerIf> >& ifaces) : ifaces_(ifaces) {
  }
  virtual ~EchoServerMultiface() {}
 protected:
  std::vector<boost::shared_ptr<EchoServerIf> > ifaces_;
  EchoServerMultiface() {}
  void add(boost::shared_ptr<EchoServerIf> iface) {
    ifaces_.push_back(iface);
  }
 public:
  void Echo(std::string& _return, const std::string& msg) {
    size_t sz = ifaces_.size();
    size_t i = 0;
    for (; i < (sz - 1); ++i) {
      ifaces_[i]->Echo(_return, msg);
    }
    ifaces_[i]->Echo(_return, msg);
    return;
  }

  void SendPacket(Packet& _return, const Packet& p) {
    size_t sz = ifaces_.size();
    size_t i = 0;
    for (; i < (sz - 1); ++i) {
      ifaces_[i]->SendPacket(_return, p);
    }
    ifaces_[i]->SendPacket(_return, p);
    return;
  }

};



#endif