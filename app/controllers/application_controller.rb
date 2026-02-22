class ApplicationController < ActionController::API
    
    private
    
    def add_cart_required_fields
        render json: { error: "Produto_id e quantidade são obrigatórios" }, status: :bad_request
    end

    def add_cart_product_not_found
        render json: { error: "Produto não encontrado" }, status: :not_found
    end
end
