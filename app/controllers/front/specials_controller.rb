class Front::SpecialsController < Front::BaseController 

  def index
  end

  def get_list
    special_topics = Stage::Special.list(page: params[:page], pagesize: params[:pageSize])

    render_datas(handle_items(special_topics))
  end

  protected
  def handle_items(items)
    items.map! do |item|
      {
        title:        item.name,
        imageUrl:     item.image_url,
        url:          '',
        startDate:    item.createddate.to_date.strftime('%Y.%m.%d'),
        endDate:      item.createddate.to_date.strftime('%Y.%m.%d'),
        description:  item.descriptio,
        likeCount:    0
      }
    end
  end
end
