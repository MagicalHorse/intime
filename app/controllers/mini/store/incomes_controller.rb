# encoding: utf-8
class Mini::Store::IncomesController < Mini::Store::BaseController

  def index

  end

  def my
    @income = Mini::Income.my(request)
    @title = "我的收益"
  end

  def new
    @banks = Mini::Income.banks(request)
    @income = Mini::Income.my(request)
    @title = "申请提现"
  end

  def create
    @income = Mini::Income.apply(request, {bank_code: params[:bank_code], bank_no: params[:bank_no], amount: params[:amount], user_name: params[:user_name]})
  end

  def list
    @search = Mini::Income.list(request, page: params[:page] || 1, pagesize: params[:per_page] || 10)
    @list = @search["data"]["items"]
    @title = "提现记录"
    respond_to do |format|
      format.html{}
      format.json{render "list"}
    end
  end

  def frozen
    @search = Mini::Income.frozen(request, page: params[:page] || 1, pagesize: params[:per_page] || 10)
    @list = @search["data"]["items"]
    @title = "不可提现列表"
    respond_to do |format|
      format.html{}
      format.json{render "frozen"}
    end
  end

  def tips

  end


end
