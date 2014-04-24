# encoding: utf-8
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
        url:          generate_special_url(item),
        startDate:    change_time_zone(item.createddate).strftime('%Y.%m.%d'),
        endDate:      change_time_zone(item.createddate).strftime('%Y.%m.%d'),
        description:  item.descriptio
      }
    end
  end

  def generate_special_url(item)
    case item.targetType
    when 0, 1
      front_products_path(topicid: item.targetId)
    when 2
      front_promotion_path(item.targetId)
    when 3
      front_product_path(item.targetId)
    when 4
      '#'
    when 5
      item.targetId
    when 6
      front_storepromotions_path
    end
  end
end
