var data=[];
            
                var AccountList = React.createClass({
                    render: function() {
                        console.log('DATA'+this.props.data);
                        var accountNodes = this.props.data.map(function (account) {
                          return (
                            <Account name={account.name} description={account.description} 
                                     phone={account.phone} fax={account.fax} type={account.type} key={account.id}>
                            </Account>
                          );
                    });
                    return (
                      <div className="slds-scrollable--x">
                          <table className="slds-table slds-table--bordered slds-max-medium-table--stacked-horizontal">
                              <thead>
                                  <tr className="slds-text-heading--label">
                                      <th scope="col">
                                          <span className="slds-truncate">Account Name</span>
                                      </th>
                                      <th scope="col">
                                          <span className="slds-truncate">Fax</span>
                                      </th>
                                      <th scope="col">
                                          <span className="slds-truncate">Phone</span>
                                      </th>
                                      <th scope="col">
                                          <span className="slds-truncate">Type</span>
                                      </th>
                                       <th scope="col">
                                          <span className="slds-truncate">Account Description</span>
                                      </th>
                                  </tr>
                              </thead>
                              <tbody>
                                  {accountNodes}
                              </tbody>
                          </table>
                      </div>
                    );
                }
            });
            
            var AccountView = React.createClass({
                  getInitialState: function() {
                        return {data:[]};
                   },
                  componentDidMount: function() {
                        makeDeferredProvider();
                        var wh = SObjectModel.deferredObject('acc');
                        // Use the Remote Object to query for 10 warehouse records
                        var whp = wh.retrieve({ limit: 100 });
                        whp.then(
                           // The first function is invoked when the promise is successfully fulfilled
                        function(records){
                          records.forEach(function(record) {
                                          // Build the Account data
                                          var dataitem = {
                                            "name": record.get("Name"),
                                            "description": record.get("desc"),
                                            "fax" : record.get("Fax"),
                                            "phone" : record.get("Phone"),
                                            "type" : record.get("Type"),
                                            "id"  :  record.get("Id")
                                          }
                                         data.push(dataitem);
                                      }.bind(this));
                                      console.log('GOT DATA HERE'+data);
                                      this.setState({data: data});
                                     
                        }.bind(this),
                        // The second function is invoked when the promise is rejected
                        function(err) {
                          
                        });
                        console.log('INSIDE DATA1'+data);
                    },
                    render: function() {
                              return (
                                <div className="myapp">
                                    <div id="accountList" className="slds-p-vertical--medium">
                                      <div className="slds-page-header" role="banner">
                                        <div className="slds-grid">
                                          <div className="slds-col">
                                            <p className="slds-text-heading--label">Accounts</p>
                                            <h1 className="slds-text-heading--medium">My Accounts</h1>
                                          </div>
                                        </div>
                                      </div>
                                      <AccountList data={this.state.data} />
                                    </div>
                                </div>
                              );
                            }
                    });
            
                var Account = React.createClass({
                      render: function() {
                        return (
                          <tr>
                              <td data-label="Name"><span className="slds-truncate">{this.props.name}</span></td>
                              <td data-label="Fax"><span className="slds-truncate">{this.props.fax}</span></td>
                              <td data-label="Phone"><span className="slds-truncate">{this.props.phone}</span></td>
                              <td data-label="Type"><span className="slds-truncate">{this.props.type}</span></td>
                              <td data-label="Description"><span className="slds-truncate">{this.props.description}</span></td>
                          </tr>
                        );
                      }
                });
                ReactDOM.render(
                   <AccountView />,
                      document.getElementById('fastVfWithReactDemo')
                );