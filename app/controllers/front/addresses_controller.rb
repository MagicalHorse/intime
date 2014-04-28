# encoding: utf-8
class Front::AddressesController < Front::BaseController
  before_filter :authenticate!

  # *output*
  # {
  #   page: 1,
  #   pagesize: 8,
  #   totalcount: 8,
  #   totalpaged: 1,
  #   datas: [
  #     {
  #       id: 1,                                               // 地址ID
  #       shippingperson: '涂马云',                            // 收获联系人
  #       shippingphone: '13011111111',                        // 送货联系电话
  #       shippingprovinceid: 1,                               // 省ID
  #       shippingprovince: '江西省',                          // 省
  #       shippingcityid: 1,                                   // 市ID
  #       shippingcity: '南昌市',                              // 市
  #       shippingdistrictid: 1,                               // 区ID
  #       shippingdistrict: '西湖区',                          // 区
  #       shippingaddress: 'xxx',                              // 送货地址
  #       shippingzipcode: '100000'                            // 邮编
  #     }
  #   ]
  # }
  def index
    @addresses = format_items(API::Address.index(request, page: 1, pagesize: 8)[:data], :page, :pagesize, :totalcount, :totalpaged)

    respond_to do |format|
      format.json { render json: @addresses, callback: params[:callback] }
      format.html
    end
  end

  # *input*
  # {
  #   order: {
  #     id: 1,                                               // 地址ID
  #     shippingperson: '涂马云',                            // 收获联系人
  #     shippingphone: '13011111111',                        // 送货联系电话
  #     shippingprovinceid: 1,                               // 省ID
  #     shippingprovince: '江西省',                          // 省
  #     shippingcityid: 1,                                   // 市ID
  #     shippingcity: '南昌市',                              // 市
  #     shippingdistrictid: 1,                               // 区ID
  #     shippingdistrict: '西湖区',                          // 区
  #     shippingaddress: 'xxx',                              // 送货地址
  #     shippingzipcode: '100000'                            // 邮编
  #   }
  # }
  #
  # *output*
  # - success
  # {
  #   isSuccessful: true,                                    // 用于判断更新是否成功
  #   statusCode: 200,
  #   message: '更新成功',                                   // 更新成功的信息
  #   data: {
  #     id: 1,                                               // 地址ID
  #     shippingperson: '涂马云',                            // 收获联系人
  #     shippingphone: '13011111111',                        // 送货联系电话
  #     shippingprovinceid: 1,                               // 省ID
  #     shippingprovince: '江西省',                          // 省
  #     shippingcityid: 1,                                   // 市ID
  #     shippingcity: '南昌市',                              // 市
  #     shippingdistrictid: 1,                               // 区ID
  #     shippingdistrict: '西湖区',                          // 区
  #     shippingaddress: 'xxx',                              // 送货地址
  #     shippingzipcode: '100000'                            // 邮编
  #   }
  # }
  # - fail
  # {
  #   isSuccessful: false,                                   // 用于判断更新是否成功
  #   statusCode: 500,
  #   message: '更新失败',                                   // 更新失败的信息
  # }
  def update
    params[:address][:shippingcontactperson] = params[:address].delete(:shippingperson)
    params[:address][:shippingcontactphone]  = params[:address].delete(:shippingphone)

    result = API::Address.update(request, params[:address].merge(id: params[:id]))
    render json: result.slice(:isSuccessful, :statusCode, :message, :data), callback: params[:callback]
  end

  # *input*
  # {
  #   order: {
  #     shippingperson: '涂马云',                            // 收获联系人
  #     shippingphone: '13011111111',                        // 送货联系电话
  #     shippingprovinceid: 1,                               // 省ID
  #     shippingprovince: '江西省',                          // 省
  #     shippingcityid: 1,                                   // 市ID
  #     shippingcity: '南昌市',                              // 市
  #     shippingdistrictid: 1,                               // 区ID
  #     shippingdistrict: '西湖区',                          // 区
  #     shippingaddress: 'xxx',                              // 送货地址
  #     shippingzipcode: '100000'                            // 邮编
  #   }
  # }
  # *output*
  # - success
  # {
  #   isSuccessful: true,                                    // 用于判断更新是否成功
  #   statusCode: 200,
  #   message: '创建成功',                                   // 创建成功的信息
  #   data: {
  #     id: 1,                                               // 地址ID
  #     shippingperson: '涂马云',                            // 收获联系人
  #     shippingphone: '13011111111',                        // 送货联系电话
  #     shippingprovinceid: 1,                               // 省ID
  #     shippingprovince: '江西省',                          // 省
  #     shippingcityid: 1,                                   // 市ID
  #     shippingcity: '南昌市',                              // 市
  #     shippingdistrictid: 1,                               // 区ID
  #     shippingdistrict: '西湖区',                          // 区
  #     shippingaddress: 'xxx',                              // 送货地址
  #     shippingzipcode: '100000'                            // 邮编
  #   }
  # }
  # - fail
  # {
  #   isSuccessful: false,                                   // 用于判断更新是否成功
  #   statusCode: 500,
  #   message: '创建失败',                                   // 创建失败的信息
  # }
  def create
    params[:address][:shippingcontactperson] = params[:address].delete(:shippingperson)
    params[:address][:shippingcontactphone]  = params[:address].delete(:shippingphone)

    result = API::Address.create(request, params[:address])
    render json: result.slice(:isSuccessful, :statusCode, :message, :data), callback: params[:callback]
  end

  def destroy
    result = API::Address.destroy(request, id: params[:id])
    render json: result.slice(:isSuccessful, :statusCode, :message, :data)
  end
end
