prawn_document() do |pdf|

  pdf.image "#{Rails.root}/app/assets/images/pdf_header.png", :position => :center
  pdf.move_down(20)

  pdf.text t('.title') + " Output", :size => 20, :style => :bold, :align => :center
  pdf.move_down(30)
  if @calculator.valid?
    
    @result = @calculator.calculate_result
    
    if I18n.locale == :metric
      input_data = [
        ["Crop" , Crop.find_by_id(@calculator.crop_id).name],
        [t('.fert'), Fertiliser.find_by_id(@calculator.fertiliser_id).metric_name],
        ["Soil Moisture", SoilMoisture.find_by_id(@calculator.soil_moisture_id).name],
        ["Soil Texture", SoilTexture.find_by_id(@calculator.soil_texture_id).name],
        [t('.furrow'), @calculator.seed_furrow_opening_width],
        [t('.spacing'), @calculator.row_spacing],
        ["Tolerated Stand Loss", @calculator.tolerated_stand_loss + "%"]
      ]
    else
      input_data = [
        ["Crop" , Crop.find_by_id(@calculator.crop_id).name],
        [t('.fert'), Fertiliser.find_by_id(@calculator.fertiliser_id).imperial_name],
        ["Soil Moisture", SoilMoisture.find_by_id(@calculator.soil_moisture_id).name],
        ["Soil Texture", SoilTexture.find_by_id(@calculator.soil_texture_id).name],
        [t('.furrow'), @calculator.seed_furrow_opening_width],
        [t('.spacing'), @calculator.row_spacing],
        ["Tolerated Stand Loss", @calculator.tolerated_stand_loss + "%"]
      ]
    end
    
    output_data = [
      [t('.result'), @calculator.result.round(1).to_s],
      [t('.sbu'), @calculator.sbu.to_s],
      [t('.liquid_weight'), @calculator.liquid_weight.to_s],
      [t('.nitrogen'), @calculator.nitrogen.to_s],
      [Prawn::Table::Cell::Text.new( pdf, [0,0], :content => t('.phosphorus'), :inline_format => true), 
        @calculator.phosphorus.to_s],
      [Prawn::Table::Cell::Text.new( pdf, [0,0], :content => t('.potassium'), :inline_format => true), 
        @calculator.potassium.to_s],
      [t('.sulphur'), @calculator.sulphur.to_s],
      [t('.magnesium'), @calculator.magnesium.to_s]    
    ]
    
    pdf.text "Calculator input:", :size => 15, :style => :bold
    pdf.move_down(5)
    pdf.table(input_data)
    
    pdf.move_down(30)
    
    pdf.text "Calculator output:", :size => 15, :style => :bold
    pdf.move_down(5)
    pdf.table(output_data)
    
  else 
    pdf.text "Calculation was not successfully completed.", :size => 15, :style => :bold, :align => :center
  end
  
  pdf.move_down(60)
  pdf.text "These results are subject to the terms and conditions.", :align => :center
  pdf.text "Please visit <u><link>seed-damage-calculator.herokuapp.com</link></u> for details.", :align => :center, :inline_format => true
  
end
